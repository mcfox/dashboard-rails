function hasParams(url) {
    var regex = new RegExp(/\?\w+\=/);
    regex.test(url);
}

function widget_load_from_ajax($el, new_url) {
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
                //console.log('sucesso');
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
}

function widget_load_user_config(user_id, $elDestBlock) {
    var $elDestList = $elDestBlock.find('.widgets_list .list');
    $.ajax({
        url: '/taxweb_widgets/widgets/user/'+user_id,
        method: 'get',
        dataType: 'html',
        beforeSend: function (jqXHR, settings) {
            widget_loading($elDestBlock);
        },
        success: function (data, textStatus, jqXHR) {
            $elDestList.html(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log('erro',jqXHR);
        },
        complete: function (jqXHR, textStatus) {
            widget_loading($elDestBlock, false);
        }
    });
}

function widget_loading(element, state) {
    var $el = $(element);
    if (state==undefined) state=true;

    if (state==true) {
        $("<div class='widget_loading'><span>Carregando...</span></div>").appendTo($el);
    } else {
        $el.find('.widget_loading').fadeOut('fast', function(){
            $(this).remove();
        });
    }
}

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

//USER CONTORL
$(document).on('change','.widget-user-control', function(ev) {
    var $el = $(this);
    widget_load_user_config($el.val(), $el);
});

$(document).on('ready',function(){

    $('.widget[data-url]').each(function(i,el) {
        var $el = $(el);
        var ticket = $el.attr('data-tick') || 0;
        widget_load_from_ajax($el);
        if (ticket > 0) {
            var interval = window.setInterval(function(){
                widget_load_from_ajax($el);
            }, ticket);
        }
    });

    //INIT
    if ($('.widget-user-control').length > 0) {
        $('.widget-user-control').trigger('change');
    } else {
        widget_load_user_config('', $('form.widget_config:first'))
    }

});
