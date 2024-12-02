$(document).ready(function() {
    //1.首先将#goTopBtn隐藏
    $("#goTopBtn").hide();

    //2.给窗口添加事件：滚动时触发
    $(window).scroll(function() {
        //当滚动条的位置处于距顶部0像素以上时，返回顶部按钮出现，否则消失
        if ($(window).scrollTop() > 0) {
            $("#goTopBtn").fadeIn(1500);
        } else {
            $("#goTopBtn").fadeOut(1500);
        }
    });

    //3.当点击返回顶部按钮后，回到页面顶部位置
    $("#goTopBtn").click(function() {
        $('body,html').animate({
            scrollTop: 0
        }, 1000);
    });
});
$(document).ready(function() {
    $(function() {
        //纵向，默认，移动间隔2
        $('div.albumSlider').albumSlider();
        //横向设置
        $('div.albumSlider-h').albumSlider({
            direction: 'h',
            step: 3
        });
    });
});
$(document).ready(function() {
    /*
     *   Examples - images
     */

    $("a#example1").fancybox();

    $("a#example2").fancybox({
        'overlayShow': false,
        'transitionIn': 'elastic',
        'transitionOut': 'elastic'
    });
    $("a#example3").fancybox({
        'transitionIn': 'none',
        'transitionOut': 'none'
    });

    $("a#example4").fancybox({
        'opacity': true,
        'overlayShow': false,
        'transitionIn': 'elastic',
        'transitionOut': 'none'
    });

    $("a#example5").fancybox();

    $("a#example6").fancybox({
        'titlePosition': 'outside',
        'overlayColor': '#000',
        'overlayOpacity': 0.9
    });

    $("a#example7").fancybox({
        'titlePosition': 'inside'
    });

    $("a#example8").fancybox({
        'titlePosition': 'over'
    });

    $("a[rel=example_group]").fancybox({
        'transitionIn': 'none',
        'transitionOut': 'none',
        'titlePosition': 'over',
        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });

    /*
     *   Examples - various
     */

    $("#various1").fancybox({
        'titlePosition': 'inside',
        'transitionIn': 'none',
        'transitionOut': 'none'
    });

    $("#various2").fancybox();

    $("#various3").fancybox({
        'width': '75%',
        'height': '75%',
        'autoScale': false,
        'transitionIn': 'none',
        'transitionOut': 'none',
        'type': 'iframe'
    });

    $("#various4").fancybox({
        'padding': 0,
        'autoScale': false,
        'transitionIn': 'none',
        'transitionOut': 'none'
    });
});
$(document).ready(function() {
    //+-替换
    $("#zhankai").toggle(function() {
        $(this).html("<b>收起目录</b>");
        $(".shouqi").html("<b>-</b>")
        $(".lanmu-content").css("display", "block")
    }, function() {
        $(this).html("<b>展开目录</b>");
        $(".shouqi").html("<b>+</b>")
        $(".lanmu-content").css("display", "none")
    })

    /*开关*/
    // $("#kaiguan").toggle(function() {
    //     $(this).html("<b> >> </b>");
    //     $("#zhankai").html("")
    //     $(".mulu").width("68px")
    //     $("#zhankai").width("0")
    //     $("#kaiguan").css({
    //         "text-align": "left",
    //         "margin": "0",
    //         "padding": "0",
    //     })
    //     $("#kaiguan").attr({
    //         "title": "点击展开目录"
    //     })
    //     $("#main").width("90%")
    //     $("#left").css({
    //         "display": "none"
    //     })
    // }, function() {
    //     $(this).html("<b> << </b>");
    //     $("#zhankai").html("<b>展开目录</b>")
    //     $(".mulu").width("14.5%")
    //     $("#main").width("78%")
    //     $("#left").css({
    //         "display": "block"
    //     })
    //     $("#kaiguan").attr({
    //         "title": "点击收起目录"
    //     })
    // })

    $("#changemulu").toggle(function() {
        $(this).css({
            "left": "2%"
        })
        $("#changemulu a").attr({
            "title": "点击展开目录"
        })
        $("#main").width("90%")
        $("#holemulu").css({
            "display": "none"
        })
    }, function() {
        $(this).css({
            "left": "2%"
        })
        $("#changemulu a").attr({
            "title": "点击收起目录"
        })
        $("#main").width("78%")
        $("#holemulu").css({
            "display": "block"
        })
    })

});
//收起栏目
$(document).ready(function() {
    $(".shouqi").toggle(function() {
            if ($(this).html() == "<b>+</b>") {
                $(this).html("<b>-</b>")
                $(this).parent().next().fadeIn("2500")
            } else {
                $(this).html("<b>+</b>")
                $(this).parent().next().fadeOut("2500")
            }

        }, function() {
            if ($(this).html() == "<b>-</b>") {
                $(this).html("<b>+</b>")
                $(this).parent().next().fadeOut("2500")
            } else {
                $(this).html("<b>-</b>")
                $(this).parent().next().fadeIn("2500")
            }

        })
        // $(".lanmu-list a").click(function(){
        // 	$(".lanmu-list a").removeClass("current")
        // 	$(this).addClass("current"); 
        // })

    $(".shouqi_2").toggle(function() {

        if ($(this).prev().html() == "<b>+</b>") {
            $(this).prev().html("<b>-</b>")
            $(this).parent().next().css("display", "block")
        } else {
            $(this).prev().html("<b>+</b>")
            $(this).parent().next().css("display", "none")
        }
    }, function() {
        if ($(this).prev().html() == "<b>-</b>") {
            $(this).prev().html("<b>+</b>")
            $(this).parent().next().css("display", "none")
        } else {
            $(this).prev().html("<b>-</b>")
            $(this).parent().next().css("display", "block")
        }
    })
});

$(document).ready(function() {
    var e = ".side-catalog .go-up";
    var n = ".side-catalog .go-down";
    // alert(e.height);
});

$(document).ready(function() {
    // 这里不能用for循环，要用each
    $(".pointer").each(function(index, element) {
        var k = index + 1;
        var j = "#title" + k;
        $(j).mouseover(function() {
            $(element).css("background-position", "3px -245px");
            // $(j + ".text").css("background-color", "#F0F8FF");
        });
        $(j).mouseout(function() {
            $(element).css("background-position", "3px -222px");
            // $(j + ".text").css("background-color", "#F0F8FF");
        });
        // $(element).mouseover(function() {
        //     $(element).css("background-position", "3px -245px");
        //     $(j).css("background-color", "#F0F8FF");

        // });
        // $(element).mouseover(function() {
        //     $(element).css("background-position", "3px -222px");
        //     $(j).css("background-color", "#FFFFFF")
        // });
    });
});