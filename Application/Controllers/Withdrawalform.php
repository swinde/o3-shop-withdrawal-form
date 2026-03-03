<?php

/**
 * vanilla-thunder/oxid-module-withdrawal-form
 * Smart Withdrawal Form for OXID eShop v6.0+
 * Copyright (C) 2021 Marat Bedoev
 *
 * This program is free software;
 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
 * either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
 */

namespace SWinde\WithdrawalForm\Application\Controllers;

use \OxidEsales\Eshop\Core\Registry;

class Withdrawalform extends \OxidEsales\Eshop\Application\Controller\FrontendController
{
    protected $_sThisTemplate = 'withdrawalform.tpl';

    public function getTitle()
    {
        return Registry::getLang()->translateString("WITHDRAWAL_FORM", Registry::getLang()->getBaseLanguage(), false);
    }

    public function getBreadCrumb()
    {
        $aPaths = array();
        $aPath = array();

        $aPath['title'] = $this->getTitle();
        $aPath['link'] = 'index.php?cl=withdrawalform';
        $aPaths[] = $aPath;

        return $aPaths;
    }

    public function isLegacyBS() {
        return (Registry::getConfig()->getConfigParam('vtWithdrawalBootstrapVersion') == "v3");
    }

    public function getUserOrders()
    {
        if ($oUser = $this->getUser()) {
            $oOrders = oxNew(\OxidEsales\Eshop\Core\Model\ListModel::class);
            $oOrders->init('oxorder');


            $sQ = 'SELECT * FROM oxorder WHERE oxuserid = :oxuserid OR oxbillemail = :oxbillemail ORDER BY oxorderdate DESC'; // and oxorderdate >= :oxorderdate
            $oOrders->selectString($sQ, [
                ':oxuserid' => $oUser->oxuser__oxid->value,
                ':oxbillemail' => $oUser->oxuser__oxusername->value,
                //':oxorderdate' => date('Y-m-d', strtotime('-30 days'))
            ]);

            return ($oOrders->count() > 0 ? $oOrders : false);
        }
        return false;
    }
    
    public function getOrderArticles()
    {
        $wdf = Registry::getConfig()->getRequestParameter("wdf");
        if (!empty($wdf["oxorderid"])) {
            $oArticleList = oxNew(\OxidEsales\Eshop\Application\Model\ArticleList::class);
            $oArticleList->init('oxorderarticle');
            $oArticleList->selectString(
                'select * from oxorderarticles where oxorderid = :oxorderid',
                [':oxorderid' => $wdf["oxorderid"] ]
            );
            $this->addTplParam("aOrderProducts", $oArticleList);
        } else {
            $this->addTplParam("aOrderProducts", false);
        }
    }
    public function getWithdrawalReasons()
    {
        $aReasonst = Registry::getConfig()->getConfigParam('vtWithdrawalReasons');
        return (!empty($aReasonst) ? $aReasonst : false);
    }

    public function getRecaptchaSiteKey()
    {
        return Registry::getConfig()->getConfigParam('vtWithdrawalCaptchaSitekey');
    }

    protected function _checkRecaptcha($token)
    {
        if (!$token) {
            $this->addTplParam("submitError", "ROBOT");
            return false;
        }

        $this->addTplParam("errorArgs", Registry::getConfig()->getActiveShop()->oxshops__oxorderemail->value);

        $client  = @$_SERVER['HTTP_CLIENT_IP'];
        $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
        $ip = $_SERVER['REMOTE_ADDR'];
        if (filter_var($client, FILTER_VALIDATE_IP)) {
            $ip = $client;
        } elseif (filter_var($forward, FILTER_VALIDATE_IP)) {
            $ip = $forward;
        }

        $data = [
            'secret' => Registry::getConfig()->getConfigParam("vtWithdrawalCaptchaSecret"),
            'response' => $token,
            'remoteip' => $ip
        ];

        $ch = curl_init('https://www.google.com/recaptcha/api/siteverify');
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POST, 1);
        //curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: text/xml'));
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $response = (object) json_decode(curl_exec($ch));
        curl_close($ch);

        if (!isset($response->success)) {
            return true;
        } // gar kein response. trotzdem email versenden
        elseif ($response->success === true) {
            return true;
        } elseif ($response->success === false) {
            $this->addTplParam("submitError", "CAPTCHA");
        } // captcha nicht bestätigt
        else {
            $this->addTplParam("submitError", "EMAILNOTSENT");
        } // sollte eigentlich nicht passieren
        return false;
    }

    public function submitWithdrawal()
    {
        $wdf = Registry::getConfig()->getRequestParameter("wdf");

        if($wdf["datenschutz"] !== "1") {
            $this->addTplParam("submitError", "DATENSCHUTZ");
            return false;
        }

        if (!Registry::getConfig()->getUser() && !$this->_checkRecaptcha(Registry::getConfig()->getRequestParameter("g-recaptcha-response"))) {
            return false;
        }

        try {
            /** @var \VanillaThunder\WithdrawalForm\Application\Extend\Email $oEmail */
            $oEmail = oxNew("oxEmail");
            $x = $oEmail->sendWithdrawalRequestToOwner($wdf);
            $y = $oEmail->sendWithdrawalRequestToUser($wdf);
        } catch (\Exception $oException) {
            $this->addTplParam("submitError", "EMAILNOTSENT");
            $this->addTplParam("errorArgs", $oEmail->getShop()->oxshops__oxorderemail->value);
        }

        if ($x) {
            $this->addTplParam("submitSuccess", true);
        } else {
            $this->addTplParam("submitError", "EMAILNOTSENT");
            $this->addTplParam("errorArgs", $oEmail->getShop()->oxshops__oxorderemail->value);
        }
        return true;
    }
}
