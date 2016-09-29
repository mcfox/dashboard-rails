$(document).on('ready',function(){

    var hasParams = function(url) {
        var regex = new RegExp(/\?\w+\=/);
        regex.test(url);
    };

    var widget_load_from_ajax = function($el, new_url) {
        if ($el!=undefined && $el!=null && $el instanceof jQuery) {
            var dest_url = (new_url != undefined ? new_url : $el.attr('data-url'));
            // var query_string = window.location.search.substring(1);
            // if (query_string!=undefined && query_string!=null) {
            //     dest_url = dest_url + (hasParams(dest_url) ? '&' : '?') + query_string;
            // }
            $.ajax({
                url: dest_url,
                method: 'get',
                dataType: 'html',
                beforeSend: function (jqXHR, settings) {
                    widget_loading($el);
                },
                success: function (data, textStatus, jqXHR) {
                    console.log('sucesso');
                    $el.html(data);

                    if (new_url != undefined) {
                        $el.attr('data-url', new_url);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('erro',jqXHR);
                },
                complete: function (jqXHR, textStatus) {
                    widget_loading($el, false);
                }
            });
        } else {
            alert('Erro! Objeto Widget Não encontrado!');
        }
    };

    var widget_loading = function(element, state) {
        var $el = $(element);
        if (state==undefined) state=true;

        if (state==true) {
            $("<div class='widget_loading'><span>Carregando...</span></div>").appendTo($el);
        } else {
            $el.find('.widget_loading').fadeOut('fast', function(){
                $(this).remove();
            });
        }
    };

    $('.widget[data-url]').each(function(i,el) {
        var $el = $(el);
        var ticket = $el.attr('data-tick') || 0;
        //
        widget_load_from_ajax($el);
        //
        if (ticket > 0) {
            var interval = window.setInterval(function(){
                widget_load_from_ajax($el);
            }, ticket);
        }
    });

    //FORMS
    $(document).on('submit','form[widget_ajax]', function(ev) {
        ev.preventDefault();
        var widget_element = $(this).closest('.widget'),
            atributos = $(this).serialize(),
            form_url = $(this).attr('action');
        if (atributos!=undefined && atributos!=null) {
            form_url = form_url + (hasParams(form_url) ? '&' : '?') + atributos;
        }
        widget_load_from_ajax(widget_element, form_url);
    });

    //LINKS
    $(document).on('click','a[widget_ajax]', function(ev) {
        ev.preventDefault();
        var widget_element  = $(this).closest('.widget');
        var new_url = $(this).attr('href');
        widget_load_from_ajax(widget_element, new_url);
    });

});




// require taxweb_widgets/jquery-3.1.1.min
// require taxweb_widgets/lodash.4.16.2.min
// require taxweb_widgets/gridstack.0.3.0.min
// require taxweb_widgets/gridstack.0.3.0.jQueryUI.min
// $(document).ready(function(){
//
//     $('body').append('<div><a class="btn btn-default" id="add-new-widget" href="#">Add Widget</a></div><br/><div class="grid-stack"></div>');
//
//     var options = {
//         float: true
//     };
//     $('.grid-stack').gridstack(options);
//
//     new function () {
//         this.items = [
//             {x: 0, y: 0, width: 2, height: 2},
//             {x: 3, y: 1, width: 1, height: 2},
//             {x: 4, y: 1, width: 1, height: 1},
//             {x: 2, y: 3, width: 3, height: 1},
// //                    {x: 1, y: 4, width: 1, height: 1},
// //                    {x: 1, y: 3, width: 1, height: 1},
// //                    {x: 2, y: 4, width: 1, height: 1},
//             {x: 2, y: 5, width: 1, height: 1}
//         ];
//
//         this.grid = $('.grid-stack').data('gridstack');
//
//         this.addNewWidget = function () {
//             var node = this.items.pop() || {
//                     x: 12 * Math.random(),
//                     y: 5 * Math.random(),
//                     width: 1 + 3 * Math.random(),
//                     height: 1 + 3 * Math.random()
//                 };
//             this.grid.addWidget($('<div><div class="grid-stack-item-content" /><div/>'), node.x, node.y, node.width, node.height, false, 1, 1, 2, 2);
//             return false;
//         }.bind(this);
//
//         $('#add-new-widget').click(this.addNewWidget);
//     };
//
// });

// require taxweb_widgets/jquery.gridster-0.7.0.min
// require taxweb_widgets/jquery.gridster-0.7.0.with-extras.min
// $(document).ready(function(){
//
//     $('body').append('<div class="controls"><button class="js-unseralize">Build from serialize</button><button class="js-seralize">Serialize</button></div><textarea id="dashboard_log"></textarea><div id="grid1" class="gridster"><ul></ul></div>');
//
//     var gridster;
//
//     // same object than generated with gridster.serialize() method
//     var serialization = [
//         { col: 1, row: 1, size_x: 4, size_y: 2, max_size_y: 6, max_size_x: 6, min_size_x: 2, min_size_y: 2},
//         { col: 5, row: 1, size_x: 2, size_y: 2 },
//         { col: 4, row: 1, size_x: 2, size_y: 2 },
//         { col: 2, row: 3, size_x: 3, size_y: 2 },
//         { col: 1, row: 4, size_x: 2, size_y: 2 },
//         { col: 1, row: 3, size_x: 2, size_y: 2 },
//         { col: 2, row: 4, size_x: 2, size_y: 2 },
//         { col: 2, row: 5, size_x: 2, size_y: 2 }
//     ];
//
//
//     // sort serialization
//     serialization = Gridster.sort_by_row_and_col_asc(serialization);
//
//     //Use resize.max_size and resize.min_size config options or data-max-sizex, data-max-sizey, data-min-sizex and data-min-sizey HTML attributes to limit widget dimensions when resizing.
//     //If a global max_size is specified through the config option, can be overwrited in specified widgets with HTML data-attributes or using set_widget_max_size method. This page has a global max limit of 4x4
//
//     gridster = $(".gridster ul").gridster({
//         namespace: '#grid1',
//         widget_base_dimensions: [100, 100],
//         widget_margins: [5, 5],
//         //helper: 'clone',
//         resize: {
//             enabled: true,
//             max_size: [4, 4],
//             min_size: [1, 1]
//         },
//         draggable: {
//             handle: 'header'
//         },
//         shift_widgets_up: false,
//         shift_larger_widgets_down: false,
//         collision: {
//             wait_for_mouseup: true
//         }
//     }).data('gridster');
//
//
//     $('.js-unseralize').on('click', function () {
//         gridster.remove_all_widgets();
//         $.each(serialization, function (i, o) {
//             widget = gridster.add_widget('<li><header>|||</header>'+i+'</li>', o.size_x, o.size_y, o.col, o.row, [o.max_size_x, o.max_size_y], [o.min_size_x, o.min_size_y] )
//         });
//     });
//
//     $('.js-seralize').on('click', function () {
//         var s = gridster.serialize();
//         $('#dashboard_log').val(JSON.stringify(s));
//     });
//
// });

// (function(window, $){
//
//     var TaxwebWidgets = function(options){
//         this.options = options;
//         this.config = null;
//         this.schedule = false;
//     };
//
//     var _this;
//
//     //INIT AND PUBLIC FUNCTIONS
//     TaxwebWidgets.prototype = {
//         defaults: {
//             container: 'body',
//             autoload: true,
//             debug: false
//         },
//         init: function () {
//
//             this.config = $.extend({}, this.defaults, this.options);
//             _this = this;
//
//             //CARREGA NO LOAD D PÁGINA
//             $(document).on("ready page:change turbolinks:load", function() {
//                 if (_this.config.autoload!==false) {_this.verify()};
//             });
//
//             $(document).on('click', '.taxweb_alerta_btn_hide', function(ev){
//                 ev.preventDefault();
//                 var $elAlert = $(this).closest('.taxweb_alerta');
//                 var id = $elAlert.attr('data-alerta-id');
//                 if (id != undefined) {
//                     _this.read(id);
//                 }
//             });
//
//             return this;
//         },
//         verify: function() {
//             var $container = $(_this.config.container);
//             if ($container.length > 0 ) {
//                 $.ajax({
//                     url: '/taxweb_widgets/gateway',
//                     method: 'get',
//                     dataType: 'json',
//                     beforeSend: function(jqXHR, settings){},
//                     success: function(data, textStatus, jqXHR) {
//                         if (data!=undefined && data.length > 0) {
//                             $.each(data, function(i,o) {
//                                 if ($('#taxweb_alerta_'+o.id).length <= 0) {
//                                     //SÓ CRIA UM NOVO ALERTA CASO ELE AINDA NÃO ESTEJA NA ELA.
//                                     $container.prepend('<div id="taxweb_alerta_'+o.id+'" data-alerta-id="'+o.id+'" class="alert '+getAlertClassByType(o.mtype)+' taxweb_alerta"><div class="actions"><a href="" class="taxweb_alerta_btn_hide">Ocultar</a></div><div class="content"><div class="message">'+o.message+'</div></div></div>');
//                                     if (o.timeout!=undefined && o.timeout>0) {
//                                         $('#taxweb_alerta_'+o.id).find('.content').append('<div class="progressbar"></div>');
//                                         startTimer('#taxweb_alerta_'+o.id, o.timeout);
//                                     }
//                                 }
//                             });
//                         }
//                     },
//                     error: function(jqXHR, textStatus, errorThrown){},
//                     complete: function(jqXHR, textStatus){}
//                 });
//             }
//         },
//         read: function(_id) {
//             $.ajax({
//                 url: '/taxweb_widgets/gateway/'+_id,
//                 method: 'put',
//                 dataType: 'json',
//                 beforeSend: function (jqXHR, settings) {
//                 },
//                 success: function (data, textStatus, jqXHR) {
//                     $('#taxweb_alerta_'+_id).slideUp('fast', function(){
//                         $(this).remove();
//                     });
//                 },
//                 error: function (jqXHR, textStatus, errorThrown) {
//                 },
//                 complete: function (jqXHR, textStatus) {
//                 }
//             });
//         }
//     };
//
//     //PRIVATE
//     function startTimer(element, timeout) {
//         var $el = $(element);
//         var $pbar = $el.find('.content .progressbar:first');
//         if ($pbar.length != undefined) {
//             $pbar.css('width', '0%');
//             $pbar.animate({width: '100%'}, (parseInt(timeout) * 1000), function () {
//                 var id = $pbar.closest('.taxweb_alerta').attr('data-alerta-id');
//                 if (id != undefined) {
//                     _this.read(id);
//                 } else {
//                     $pbar.remove();
//                 }
//             });
//         }
//     }
//
//     function getAlertClassByType(type) {
//         if (type=='error') type='danger';
//         var validTypes = ['danger','success','info','warning'];
//         return (validTypes.indexOf(type) >=0 ? 'alert-'+type : 'alert-info');
//     };
//
//     TaxwebWidgets.defaults = TaxwebWidgets.prototype.defaults;
//
//     window.TaxwebWidgets = TaxwebWidgets;
//
// })(window, jQuery);