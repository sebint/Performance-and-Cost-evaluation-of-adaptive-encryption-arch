/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// global variables
var isIE8 = false;
var isIE9 = false;
var $windowWidth;
var $windowHeight;
var $pageArea;
//Main Function
var Main = function () {
   //function to detect explorer browser and its version
    var runInit = function () {
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) {
            var ieversion = new Number(RegExp.$1);
            if (ieversion == 8) {
                isIE8 = true;
            } else if (ieversion == 9) {
                isIE9 = true;
            }
        }
    };
 //function to activate the panel tools
    var runModuleTools = function () {
        $('.panel-tools .panel-expand').bind('click', function (e) {
            $('.panel-tools a').not(this).hide();
            $('body').append('<div class="full-white-backdrop"></div>');
            $('.main-container').removeAttr('style');
            backdrop = $('.full-white-backdrop');
            wbox = $(this).parents('.panel');
            wbox.removeAttr('style');
            if (wbox.hasClass('panel-full-screen')) {
                backdrop.fadeIn(200, function () {
                    $('.panel-tools a').show();
                    wbox.removeClass('panel-full-screen');
                    backdrop.fadeOut(200, function () {
                        backdrop.remove();
                    });
                });
            } else {
                $('body').append('<div class="full-white-backdrop"></div>');
                backdrop.fadeIn(200, function () {
                    $('.main-container').css({
                        'max-height': $(window).outerHeight() - $('header').outerHeight() - $('.footer').outerHeight() - 100,
                        'overflow': 'hidden'
                    });
                    backdrop.fadeOut(200);
                    backdrop.remove();
                    wbox.addClass('panel-full-screen').css({
                        'max-height': $(window).height(),
                        'overflow': 'auto'
                    });;
                });
            }
        });
        $('.panel-tools .panel-close').bind('click', function (e) {
            $(this).parents(".panel").remove();
            e.preventDefault();
        });
        $('.panel-tools .panel-refresh').bind('click', function (e) {
            var el = $(this).parents(".panel");
            el.block({
                overlayCSS: {
                    backgroundColor: '#fff'
                },
                message: '<img src="assets/images/loading.gif" /> Just a moment...',
                css: {
                    border: 'none',
                    color: '#333',
                    background: 'none'
                }
            });
            window.setTimeout(function () {
                el.unblock();
            }, 1000);
            e.preventDefault();
        });
        $('.panel-tools .panel-collapse').bind('click', function (e) {
            e.preventDefault();
            var el = jQuery(this).parent().closest(".panel").children(".panel-body");
            if ($(this).hasClass("collapses")) {
                $(this).addClass("expand").removeClass("collapses");
                el.slideUp(200);
            } else {
                $(this).addClass("collapses").removeClass("expand");
                el.slideDown(200);
            }
        });
    };  
    //Set of functions for Style Selector
    var runStyleSelector = function () {
        $('#style_selector select').each(function () {
            $(this).find('option:first').attr('selected', 'selected');
        });
        $('.style-toggle').bind('click', function () {
            if ($(this).hasClass('open')) {
                $(this).removeClass('open').addClass('close');
                $('#style_selector_container').hide();
            } else {
                $(this).removeClass('close').addClass('open');
                $('#style_selector_container').show();
            }
        });
        setColorScheme();
        setLayoutStyle();
        setHeaderStyle();
        setFooterStyle();
        setBoxedBackgrounds();
    };
    $('.drop-down-wrapper').perfectScrollbar({
        wheelSpeed: 50,
        minScrollbarLength: 20,
        wheelPropagation: true
    });
    $('.navbar-tools .dropdown').on('shown.bs.dropdown', function () {
        $(this).find('.drop-down-wrapper').scrollTop(0).perfectScrollbar('update');
    });
    var setColorScheme = function () {
        $('.icons-color a').bind('click', function () {
            $('.icons-color img').each(function () {
                $(this).removeClass('active');
            });
            $(this).find('img').addClass('active');
            $('#skin_color').attr("href", "assets/css/theme_" + $(this).attr('id') + ".css");
        });
    };
    var setBoxedBackgrounds = function () {
        $('.boxed-patterns a').bind('click', function () {
            if ($('body').hasClass('layout-boxed')) {
                var classes = $('body').attr("class").split(" ").filter(function (item) {
                    return item.indexOf("bg_style_") === -1 ? item : "";
                });
                $('body').attr("class", classes.join(" "));
                $('.boxed-patterns img').each(function () {
                    $(this).removeClass('active');
                });
                $(this).find('img').addClass('active');
                $('body').addClass($(this).attr('id'));
            } else {
                alert('Select boxed layout');
            }
        });
    };
    var setLayoutStyle = function () {
        $('select[name="layout"]').change(function () {
            if ($('select[name="layout"] option:selected').val() == 'boxed')
                $('body').addClass('layout-boxed');
            else
                $('body').removeClass('layout-boxed');
        });
    };
    var setHeaderStyle = function () {
        $('select[name="header"]').change(function () {
            if ($('select[name="header"] option:selected').val() == 'default')
                $('body').addClass('header-default');
            else
                $('body').removeClass('header-default');
        });
    };
    var setFooterStyle = function () {
        $('select[name="footer"]').change(function () {
            if ($('select[name="footer"] option:selected').val() == 'fixed')
                $('body').addClass('footer-fixed');
            else
                $('body').removeClass('footer-fixed');
        });
    };
    var debounce = function (func, threshold, execAsap) {
        var timeout;
        return function debounced() {
            var obj = this,
                args = arguments;

            function delayed() {
                if (!execAsap)
                    func.apply(obj, args);
                timeout = null;
            };
            if (timeout)
                clearTimeout(timeout);
            else if (execAsap)
                func.apply(obj, args);
            timeout = setTimeout(delayed, threshold || 50);
        };
    };
    //Window Resize Function
    var runWIndowResize = function (func, threshold, execAsap) {
        //wait until the user is done resizing the window, then execute
        $(window).resize = debounce(function (e) {
            runElementsPosition();
        }, 50, false);
        $('.panel-scroll').perfectScrollbar({
            wheelSpeed: 50,
            minScrollbarLength: 20,
            wheelPropagation: true
        });
    };
    return {
        //main function to initiate template pages
        init: function () {
            runWIndowResize();
            runInit();
            runStyleSelector();
            runModuleTools();
        }
    };
}();
