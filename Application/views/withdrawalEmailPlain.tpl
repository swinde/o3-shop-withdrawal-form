[{assign var="shop"     value=$oEmailView->getShop()}]
[{assign var="user"     value=$oEmailView->getUser()}]

[{capture name="content"}]
--- Kunde ---
[{ $wdf.name}]
[{ $wdf.street}]
[{ $wdf.zipcity}]
[{ $wdf.country}]
[{if $oUser && $toOwner}]
Shop-Kundennummer: [{$oUser->oxuser__oxcustnr->value}]
[{if $oUser->oxuser__oxusername->value !== $wdf.email }]Shop-Email-Adresse: [{$oUser->oxuser__oxusername->value}]<br/>[{/if}]
[{/if}]

[{if $oOrder}]
[{assign var="oPaymentType" value=$oOrder->getPaymentType()}]
Bestellung Nr./Datum:  [{$oOrder->oxorder__oxordernr->value}] vom [{$oOrder->oxorder__oxorderdate->value}]
Zahlungsart: [{$oPaymentType->oxpayments__oxdesc->value}]
[{else}]
Bestellung Nr./Datum: [{$wdf.order}]
[{/if}]

[{foreach from=$wdf.products item="_product"}]
[{if $_product.return === "1" }]
-> [{$_product.title}]
Gründe: [{foreach from=$_product.reasons key="_key" item="_reason"}][{if $_reason !== ""}][{$_reason}], [{/if}][{/foreach}]
[{/if}]
[{/foreach}]
[{/capture}]
[{if $toUser}]

Sehr geehre/-r [{$wdf.name}],
Sie haben soeben den folgenden Antrag auf Widerruf gestellt:

[{$smarty.capture.content}]

[{if $retoureportal}]
Bitte nutzen Sie den folgenden Link für die Erstellung eines Versandaufklebers:
[{$retoureportal}]
Der Versand ist für Sie kostenlos.
[{/if}]

[{oxcontent ident="withdrawalemailendplain"}]
[{else}]
Hallo,
soeben wurde im [{$shop->oxshops__oxname->value}] Shop folgender Antrag auf Widerruf gestellt:

[{$smarty.capture.content}]
[{/if}]
