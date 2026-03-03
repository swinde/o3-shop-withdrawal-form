[{capture append="oxidBlock_content"}]
    [{assign var="oldBS" value=$oView->isLegacyBS()}]
    [{assign var="template_title" value=$oView->getTitle()}]

    <h1 class="page-header">[{$template_title}]</h1>
    <form class="form-horizontal" action="[{$oViewConf->getSslSelfLink()}]" method="post" role="form" id="wdf">
        <div class="hidden">
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="fnc" value=""/>
            <input type="hidden" name="cl" value="[{$oView->getClassname()}]"/>
            <input type="hidden" name="user" value="[{$oxcmp_user->oxuser__oxusername->value}]"/>
        </div>

        <div class="row justify-content-md-center">
            [{* <div class="col-12 col-md-3 col-lg-2"></div> *}]
            [{if $submitSuccess}]
                <div class="col-12 col-md-8 [{if $oldBS}]col-md-push-2[{/if}]">
                    <div class="alert alert-success">[{oxmultilang ident="WITHDRAWAL_SUCCESS"}]</div>
                </div>
            [{else}]
                <div class="col-12 col-md-8 [{if $oldBS}]col-md-push-2[{/if}]">
                    <div class="alert alert-info">Bitte füllen Sie sorgfältig dieses Fomular aus. Im Anscfhluß erhalten Sie eine Email mit Ihren Angaben und Instruktionen für den Rückversand der Ware.
                    </div>

                    <div class="form-group">
                        <label for="wdfname" class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">[{oxmultilang ident="FIRST_NAME"}]
                            , [{oxmultilang ident="LAST_NAME"}] <b>*</b></label>
                        <div class="col-sm-7 col-md-8">
                            <input type="text" class="form-control" id="wdfname" name="wdf[name]" required autocomplete="shipping name"
                                   value="[{if $smarty.post.wdf.name}][{$smarty.post.wdf.name}][{elseif $oxcmp_user}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]">
                        </div>
                    </div> [{* NAME *}]
                    <div class="form-group">
                        <label for="wdfemail" class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">[{oxmultilang ident="STREET_AND_STREETNO"}] <b>*</b></label>
                        <div class="col-sm-7 col-md-8">
                            <input type="text" class="form-control" id="wdfstreet" name="wdf[street]" required autocomplete="shipping street-address"
                                   value="[{if $smarty.post.wdf.street}][{$smarty.post.wdf.street}][{elseif $oxcmp_user}][{$oxcmp_user->oxuser__oxstreet->value}] [{$oxcmp_user->oxuser__oxstreetnr->value}][{/if}]">
                        </div>
                    </div> [{* STRASSE *}]
                    <div class="form-group">
                        <label for="wdfemail" class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">[{oxmultilang ident="POSTAL_CODE_AND_CITY"}] <b>*</b></label>
                        <div class="col-sm-7 col-md-8">
                            <input type="text" class="form-control" id="wdfzipcity" name="wdf[zipcity]" required autocomplete="shipping postal-code address-level2"
                                   value="[{if $smarty.post.wdf.zipcity}][{$smarty.post.wdf.zipcity}][{elseif $oxcmp_user}][{$oxcmp_user->oxuser__oxzip->value}] [{$oxcmp_user->oxuser__oxcity->value}][{/if}]">
                        </div>
                    </div> [{* PLZ ORT *}]
                    <div class="form-group">
                        <label class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">[{oxmultilang ident="COUNTRY"}] <b>*</b></label>
                        <div class="col-sm-7 col-md-8">
                            [{if $oViewConf->getCountryList()|@count == 1}]
                                [{foreach from=$oViewConf->getCountryList() item="_country"}]
                                <input type="text" class="form-control" id="wdfcountry" name="wdf[country]" required value="[{$_country->oxcountry__oxtitle->value}]" readonly autocomplete="shipping country-name">
                                [{/foreach}]
                            [{else}]
                                <select name="wdf[country]" class="[{if $oldBS}]form-control[{else}]custom-select[{/if}]" required>
                                    <option>Wählen Sie Ihr Land</option>
                                    [{foreach from=$oViewConf->getCountryList() item="_country"}]
                                        <option id="wdfcountry_[{$_country->oxcountry__oxid->value}]" value="[{$_country->oxcountry__oxtitle->value}]"
                                                [{if $smarty.post.wdf.country == $_country->oxcountry__oxtitle->value || $oxcmp_user->oxuser__oxcountryid->value == $_country->oxcountry__oxid->value }]selected[{/if}]>
                                            [{$_country->oxcountry__oxtitle->value}]
                                        </option>
                                    [{/foreach}]
                                </select>
                            [{/if}]
                        </div>
                    </div> [{* Land *}]
                    <div class="form-group">
                        <label for="wdfemail" class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">[{oxmultilang ident="EMAIL_ADDRESS"}] <b>*</b></label>
                        <div class="col-sm-7 col-md-8">
                            <input type="email" class="form-control" id="wdfemail" name="wdf[email]" required autocomplete="email"
                                   value="[{$smarty.post.wdf.email|default:$oxcmp_user->oxuser__oxusername->value}]">
                        </div>
                    </div> [{* Email *}]
                    <div class="form-group">
                        <label for="wdforder" class="[{if $oldBS}]control[{else}]col-form[{/if}]-label col-sm-5 col-md-4 text-right">
                            [{oxmultilang ident="PAGE_TITLE_ORDER"}]
                            [{if !$oView->getUserOrders()}][{oxmultilang ident="NUMBER_2"}] & [{oxmultilang ident="DATE"}][{/if}] <b>*</b>
                        </label>
                        <div class="col-sm-7 col-md-8">
                            [{if !$oView->getUserOrders()}]
                                <input type="text" class="form-control" id="wdforder" name="wdf[order]" required autocomplete="off" value="[{$smarty.post.wdf.order}]">
                            [{else}]
                                <select name="wdf[oxorderid]" id="wdforder" class="form-control" required>
                                    <option value="">- [{oxmultilang ident="PLEASE_CHOOSE"}] -</option>
                                    [{foreach from=$oView->getUserOrders() item="_order"}]
                                        <option value="[{$_order->oxorder__oxid->value}]" [{if $smarty.post.wdf.oxorderid == $_order->oxorder__oxid->value}]selected[{/if}]>
                                            Bestellung Nr.[{$_order->oxorder__oxordernr->value}] vom [{$_order->oxorder__oxorderdate->value}]
                                        </option>
                                    [{/foreach}]
                                </select>
                            [{/if}]
                        </div>
                    </div> [{* Bestellung *}]

                </div>
                <div class="col-12 col-md-10 pt-4 [{if $oldBS}]col-md-push-1[{/if}]">
                    [{if $oxcmp_user && $oView->getUserOrders() && !$smarty.post.wdf.oxorderid }]
                        [{* angemeldeter benutzer + hat Bestellungen + noch keine Bestellung ausgewählt*}]
                        <div class="alert alert-info text-center" role="alert">Wählen Sie Ihre Bestellung aus der Liste</div>
                    [{elseif $oxcmp_user && $oView->getUserOrders() && $aOrderProducts && $aOrderProducts|@count >= 1 }]
                        [{* angemeldeter benutzer + Bestellung ausgewählt +  Zeige Liste der Produkte aus der Bestellung *}]

                        [{if $aOrderProducts|@count == 1}]
                            <h3>Sie widerrufen den Kauf von folgendem Produkt:</h3>
                        [{else}]
                            <h3>Welcher Produkte möchten Sie zurück geben?</h3>
                        [{/if}]

                        [{foreach from=$aOrderProducts item="_orderaarticle" key="_oxid"}]
                            <div class="form-group pt-2">
                                [{* checkbox + name *}]
                                <div class="checkbox col-12 col-md-5">
                                    <h4>
                                        [{$_orderaarticle->oxorderarticles__oxtitle->value}]
                                        [{$_orderaarticle->oxorderarticles__oxselvariant->value}]<br/>
                                        ( x[{$_orderaarticle->oxorderarticles__oxamount->value}] für [{oxprice price=$_orderaarticle->oxorderarticles__oxbrutprice->value}] )
                                    </h4>
                                    <input type="hidden" name="wdf[products][[{$_oxid}]][title]"
                                           value="[{$_orderaarticle->oxorderarticles__oxtitle->value}] [{$_orderaarticle->oxorderarticles__oxselvariant->value}] ([{$_orderaarticle->oxorderarticles__oxartnum->value}])">
                                    [{if $aOrderProducts|@count == 1 }]
                                        [{* es gibt nur ein Produkt in der Bestellung *}]
                                        <input type="hidden" name="wdf[products][[{$_oxid}]][return]" value="1">
                                    [{else}]
                                        [{* zeige chekbox bei mehreren produkten *}]
                                        <div class="checkbox">
                                            <input type="hidden" name="wdf[products][[{$_oxid}]][return]" value="0">
                                            <label for="return_[{$_oxid}]" class="btn btn-danger">
                                                <input type="checkbox" name="wdf[products][[{$_oxid}]][return]" value="1" id="return_[{$_oxid}]">
                                                Kauf widerrufen
                                            </label>
                                        </div>
                                    [{/if}]
                                </div>

                                [{* eigener Grund *}]
                                <div class="col-12 col-md-4">
                                <textarea name="wdf[products][[{$_oxid}]][reasons][custom]" class="form-control" rows="[{$oView->getWithdrawalReasons()|@count|default:4}]"
                                          placeholder="Warum möchten Sie dieses Produkt zurück geben?"></textarea>
                                </div>

                                [{* vordefinierte Gründe *}]
                                <div class="col-12 col-md-3">
                                    [{foreach from=$oView->getWithdrawalReasons() key="_key" item="_item"}]
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="wdf[products][[{$_oxid}]][reasons][[{$_key}]]" id="[{$_key}]" value="[{$_item}]"
                                                       [{if $smarty.post.wdf.products[$_oxid].reasons[$_key] }]checked[{/if}]> [{$_item}]
                                            </label>
                                        </div>
                                    [{/foreach}]
                                </div>
                            </div>
                            <hr/>
                        [{/foreach}]

                    [{else}]
                        [{* nicht angemeldet oder hat keine Bestellungen oder keine Produkte in der Bestellung?! *}]
                        <h4>Den Kauf welcher Produkte möchten Sie widerrufen? <b>*</b></h4>
                        <div class="form-group">
                            <div class="col-12">
                                <input type="hidden" name="wdf[products][0][return]" value="1">
                                <textarea name="wdf[products][0][title]" class="form-control" rows="4" placeholder="Produktname (ggf. Artikelnummer), Menge und Preis"
                                          required>[{$smarty.post.wdf.products[0].title}]</textarea>
                            </div>
                        </div>
                        [{* Grund *}]
                        <h4>Würden Sie uns auch den Grund für den Widerruf nennen?</h4>
                        <div class="form-group">
                            <div class="col-12 col-sm-4">
                                [{foreach from=$oView->getWithdrawalReasons() key="_key" item="_item"}]
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="wdf[products][0][reasons][[{$_key}]]" id="[{$_key}]" value="[{$_item}]"
                                                   [{if $smarty.post.wdf.products[0].reasons[$_key] }]checked[{/if}]> [{$_item}]
                                        </label>
                                    </div>
                                [{/foreach}]
                            </div>
                            <div class="col-12 col-sm-8">
                            <textarea name="wdf[products][0][reasons][custom]" class="form-control" rows="[{$oView->getWithdrawalReasons()|@count|default:4}]"
                                      placeholder="Was anderes? Hier können Sie einen anderen Grund angeben">[{$smarty.post.wdf.products[0].reasons.custom}]</textarea>
                            </div>
                        </div>
                    [{/if}]

                    [{if ( $oView->getUserOrders() && $smarty.post.wdf.oxorderid ) || !$oView->getUserOrders() }]
                        <div class="row justify-content-md-center pt-5" id="submitError">
                            [{if $submitError}]
                                <div class="col-12 col-md-10 [{if $oldBS}]col-md-push-1[{/if}]">
                                    <div class="alert alert-danger">
                                        [{oxmultilang ident="WITHDRAWAL_ERROR_"|cat:$submitError args=$errorArgs }]
                                    </div>
                                </div>
                            [{/if}]
                        </div>
                        <div class="form-group">
                            <div class="col-12 col-md-6 col-xl-5">
                                [{if !$oxcmp_user}]
                                    <script src='https://www.google.com/recaptcha/api.js'></script>
                                    <div class="g-recaptcha" data-sitekey="[{$oView->getRecaptchaSiteKey()}]"></div>
                                [{/if}]
                            </div>
                            <div class="col-12 col-md-6 col-xl-7">
                                <p class="form-check">
                                    <input type="hidden" name="wdf[datenschutz]" value="0">
                                    <input class="form-check-input" type="checkbox" name="wdf[datenschutz]" value="1" id="datenschutzok" required
                                           [{if $smarty.post.wdf.datenschutz == "1"}]checked[{/if}]>
                                    <label class="form-check-label" for="datenschutzok">
                                        <b>*</b> Ich habe die <a href="[{oxgetseourl type='oxcontent' ident='oxsecurityinfo'}]" target="_blank"><u>Datenschutzbestimmungen</u></a> gelesen und
                                        akzeptiert.
                                    </label>
                                </p>
                                <p>
                                    <button id="submit" type="submit" class="btn btn-danger btn-lg btn-block" name="fnc" value="submitWithdrawal">[{oxmultilang ident="WITHDRAWAL_FORM_SEND"}]</button>
                                </p>
                            </div>
                        </div>
                    [{/if}]
                </div>
            [{/if}]
        </div>
    </form>
    <script>
        [{capture name="wdfjs"}]
        [{if $oxcmp_user && $oView->getUserOrders() }]
        $("body").on("change", "select#wdforder", function ()
        {
            $.ajax({
                url: $("#wdf").attr('action'),
                type: 'POST',
                data: $("#wdf").serialize() + '&fnc=getOrderArticles&ajax=1',
                success: function (result)
                {
                    $("#content").html(result);
                }
            });
        });
        [{/if}]
        $("body").on("click", "#submit", function (e)
        {
            e.preventDefault();
            e.stopPropagation();
            if (!$("#wdfname").val() || !$("#wdfstreet").val() || !$("#wdfzipcity").val() || !$("#wdfemail").val() || !$("#wdforder").val() )
            {
                $("#submitError").html('<div class="col-12"><div class="alert alert-danger">Bitte füllen Sie alle Pflichtfelder aus.</div></div>');
                return false;
            }
            $.ajax({
                url: $("#wdf").attr('action'),
                type: 'POST',
                data: $("#wdf").serialize() + '&fnc=submitWithdrawal&ajax=1',
                success: function (result)
                {
                    //console.log(result);
                    $("#content").html(result);
                }
            });
        });
        [{/capture}]
    </script>
    [{oxscript add=$smarty.capture.wdfjs}]
[{/capture}]

[{if !$oView->getRecaptchaSiteKey() }]
    <br/><br/>
    <div style="text-align: center"><h2>reCaptcha Site Key und Secret müssen in den Moduleinstellungen konfiguriert werden!</h2></div>
[{elseif $smarty.post.ajax=="1"}]
    [{foreach from=$oxidBlock_content item="_block"}]
        [{$_block}]
    [{/foreach}]
[{else}]
    [{include file="layout/page.tpl"}]
[{/if}]


