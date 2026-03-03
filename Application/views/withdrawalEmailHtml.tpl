[{assign var="shop"     value=$oEmailView->getShop()}]
[{assign var="oViewConf" value=$oEmailView->getViewConfig()}]
[{assign var="user"     value=$oEmailView->getUser()}]

[{capture name="content"}]
    <p>
        <b>Kunde:</b><br/>
        [{ $wdf.name}]<br/>
        [{ $wdf.street}]<br/>
        [{ $wdf.zipcity}]<br/>
        [{ $wdf.country}]<br/>
        [{ $wdf.email}]
    </p>
    [{if $oUser && $toOwner}]
        <p>
            <b>Shop-Kundennummer:</b> [{$oUser->oxuser__oxcustnr->value}]<br/>
            [{if $oUser->oxuser__oxusername->value !== $wdf.email }]<b>Shop-Email-Adresse:</b> [{$oUser->oxuser__oxusername->value}]<br/>[{/if}]
        </p>
    [{/if}]

    [{if $oOrder}]
        <p>
            <b>Bestellung Nr./Datum:</b> [{$oOrder->oxorder__oxordernr->value}] vom [{$oOrder->oxorder__oxorderdate->value}]<br/>
            [{assign var="oPaymentType" value=$oOrder->getPaymentType()}]
            <b>Zahlungsart:</b> [{$oPaymentType->oxpayments__oxdesc->value}]<br/>
        </p>
    [{else}]
        <p><b>Bestellung Nr./Datum:</b> [{$wdf.order}]</p>
    [{/if}]

    [{foreach from=$wdf.products item="_product"}]
        [{if $_product.return === "1" }]
            <p>
                <b>[{$_product.title}]</b><br/>
                Gründe: [{foreach from=$_product.reasons key="_key" item="_reason"}][{if $_reason !== ""}][{$_reason}], [{/if}][{/foreach}]
            </p>
        [{/if}]
    [{/foreach}]
[{/capture}]

[{if $toUser}]
    [{include file="email/html/header.tpl" title=""}]
    <div class="block" style="width:100%;display:inline-block;vertical-align:top;">
        <table width="100%">
            <tr>
                <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                    <h3>Sehr geehre/-r [{$wdf.name}],</h3>
                    <p>Sie haben soeben den folgenden Antrag auf Widerruf gestellt:</p>

                    [{$smarty.capture.content}]

                    [{if $retoureportal}]
                        <p>
                        <h3>Bitte nutzen Sie den folgenden Link für die Erstellung eines Versandaufklebers:</h3>
                        <a href="[{$retoureportal}]">[{$retoureportal}]</a><br/> der Versand ist für Sie kostenlos.
                        </p>
                    [{/if}]
                    <br>
                    <br>
                    <br>
                    <p>
                        [{oxcontent ident="withdrawalemailend"}]
                    </p>
                </td>
            </tr>
        </table>
    </div>
    [{include file="email/html/footer.tpl"}]
[{else}]
    <h3>Hallo, </h3>
    <p>soeben wurde im [{$shop->oxshops__oxname->value}] Shop folgender Antrag auf Widerruf gestellt:</p>

    [{$smarty.capture.content}]
[{/if}]
