/**
 * jQuery plugin for Pretty looking right click context menu.
 *
 * Requires popup.js and popup.css to be included in your page. And jQuery, obviously.
 *
 * Usage:
 *
 *   $('.something').contextPopup({
 *     title: 'Some title',
 *     items: [
 *       {label:'My Item', icon:'/some/icon1.png', action:function() { alert('hi'); }},
 *       {label:'Item #2', icon:'/some/icon2.png', action:function() { alert('yo'); }},
 *       null, // divider
 *       {label:'Blahhhh', icon:'/some/icon3.png', action:function() { alert('bye'); }},
 *     ]
 *   });
 *
 * Icon needs to be 16x16. I recommend the Fugue icon set from: http://p.yusukekamiyamane.com/ 
 *
 * - Joe Walnes, 2011 http://joewalnes.com/
 *   https://github.com/joewalnes/jquery-simple-context-menu
 *
 * MIT License: https://github.com/joewalnes/jquery-simple-context-menu/blob/master/LICENSE.txt
 */
jQuery.fn.contextPopup = function (menuData) {
    // Define default settings
    var settings = {
        contextMenuClass: 'contextMenuPlugin',
        gutterLineClass: 'gutterLine',
        headerClass: 'li_header',
        seperatorClass: 'divider',
        title: '',
        items: []
    };

    // merge them
    $.extend(settings, menuData);

    //IE的Array 没有forEach方法， 我们就给它手动添加这个原型方法
    if (navigator.userAgent.indexOf("MSIE") > 0) {
        if (!Array.prototype.forEach) {
            Array.prototype.forEach = function (callback, thisArg) {
                var T, k;
                if (this == null) {
                    throw new TypeError(" this is null or not defined");
                }
                var O = Object(this);
                var len = O.length >>> 0; // Hack to convert O.length to a UInt32  
                if ({}.toString.call(callback) != "[object Function]") {
                    throw new TypeError(callback + " is not a function");
                }
                if (thisArg) {
                    T = thisArg;
                }
                k = 0;
                while (k < len) {
                    var kValue;
                    if (k in O) {
                        kValue = O[k];
                        callback.call(T, kValue, k, O);
                    }
                    k++;
                }
            };
        }
    }
    // Build popup menu HTML
    function createMenu(e) {
        var menu = $('<ul id="contextMenu_u" class="' + settings.contextMenuClass + '"><div class="' + settings.gutterLineClass + '"></div></ul>')
          .appendTo(document.body);
        if (settings.title) {
            $('<li class="' + settings.headerClass + '"></li>').text(settings.title).appendTo(menu);
        }
        settings.items.forEach(function (item) {
            if (item&&item.enable==true) {
                var rowCode = '<li><a href="#"><span></span></a></li>';
                // if(item.icon)
                //   rowCode += '<img>';
                // rowCode +=  '<span></span></a></li>';
                var row = $(rowCode).appendTo(menu);
                if (item.icon) {
                    var icon = $('<img>');
                    icon.attr('src', item.icon);
                    icon.attr('border','0');
                    icon.insertBefore(row.find('span'));
                }
                row.find('span').text(item.label);
                if (item.color)
                {
                    row.find('span').css({ "color": item.color });
                }
                if (item.action) {
                    row.find('a').click(function () { item.action(e); });
                }
            } else {
               // $('<li class="' + settings.seperatorClass + '"></li>').appendTo(menu);
            }
        });
        menu.find('.' + settings.headerClass).text(settings.title);
        return menu;
    }

    // On contextmenu event (right click)
    this.bind('contextmenu', function (e) {
        var menu = document.getElementById("contextMenu_u");
        if (menu) menu = $(menu);
        else menu = createMenu(e).show();
        var left = e.pageX + 5, /* nudge to the right, so the pointer is covering the title */
            top = e.pageY;
        if (top + menu.height() >= $(window).height()) {
            top -= menu.height();
        }
        if (left + menu.width() >= $(window).width()) {
            left -= menu.width();
        }
        // Create and show menu
        menu.css({ zIndex: 1000001, left: left, top: top })
          .bind('contextmenu', function () { return false; });

        // Cover rest of page with invisible div that when clicked will cancel the popup.
        var bg = $('<div></div>')
          .css({ left: 0, top: 0, width: '100%', height: '100%', position: 'absolute', zIndex: 1000000 })
          .appendTo(document.body)
          .bind('contextmenu click', function () {
              // If click or right click anywhere else on page: remove clean up.
              bg.remove();
              menu.remove();
              return false;
          });
        // When clicking on a link in menu: clean up (in addition to handlers on link already)
        menu.find('a').click(function () {
            bg.remove();
            menu.remove();
        });
        // Cancel event, so real browser popup doesn't appear.
        return false;
    });

    return this;
};

