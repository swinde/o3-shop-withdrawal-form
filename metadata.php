<?php

/**
 * vanilla-thunder/oxid-module-withdrawal-form
 * Smart Withdrawal Form for OXID eShop v6.2+
 * Copyright (C) 2020 Marat Bedoev
 *
 * This program is free software;
 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
 * either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
 */

$sMetadataVersion = '2.0';
$aModule = [
    'id' => 'withdrawal-form',
    'title' => [
        'de' => '[bee] Widerrufsformular',
        'en' => '[bee] Withdrawal Form'
    ],
    'description' => [
        'de' => 'das etwas intelligentere Widerrufsformular',
        'en' => 'slightly smarty withdrawal form'
    ],
    'thumbnail' => 'out/pictures/plugin.png',
    'version' => '0.5.0 (2026-03-01)',
    'author' => 'Marat Bedoev, Steffen Winde',
    'email' => openssl_decrypt("Az6pE7kPbtnTzjHlPhPCa4ktJLphZ/w9gKgo5vA//p4=", str_rot13("nrf-128-pop"), str_rot13("gvalzpr")),
    'url' => 'https://github.com/swinde/o3-shop-withdrawal-form',
    'extend' => [
        \OxidEsales\Eshop\Core\Email::class => SWinde\WithdrawalForm\Application\Extend\Email::class,
    ],
    'controllers' => [
        'withdrawalform' => SWinde\WithdrawalForm\Application\Controllers\Withdrawalform::class,
    ],
    'templates' => [
        'withdrawalform.tpl' => 'swinde/withdrawal-form/Application/views/withdrawalform.tpl',
        'withdrawalEmailHtml.tpl' => 'swinde/withdrawal-form/Application/views/withdrawalEmailHtml.tpl',
        'withdrawalEmailPlain.tpl' => 'swinde/withdrawal-form/Application/views/withdrawalEmailPlain.tpl'
    ],
    'blocks' => [
        [
            'template'=> 'widget/footer/info.tpl',
            'block'=>'footer_information',
            'file'=>'Application/views/blocks/widget/footer/footer_information.tpl'
        ],
    ],
    'settings' => [
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalCaptchaSitekey',
            'type' => 'str',
            'value' => '',
            'position' => 0
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalCaptchaSecret',
            'type' => 'str',
            'value' => '',
            'position' => 1
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalReasons',
            'type' => 'aarr',
            'value' => [
                'small' => 'zu klein',
                'large' => 'zu groß',
                'dislike' => 'nicht gefallen',
                'defect' => 'defekt',
                'damaged' => 'beschädigt'
            ],
            'position' => 2
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalEmail',
            'type' => 'str',
            'value' => '',
            'position' => 3
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalCC',
            'type' => 'arr',
            'value' => [],
            'position' => 4
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalRetoureportal',
            'type' => 'str',
            'value' => '',
            'position' => 5
        ],
        [
            'group' => 'vtWithdrawalMain',
            'name' => 'vtWithdrawalBootstrapVersion',
            'type' => 'select',
            'value' => 'v3',
            'constraints' => 'v3|v4',
            'position' => 6
        ]
    ]
];
