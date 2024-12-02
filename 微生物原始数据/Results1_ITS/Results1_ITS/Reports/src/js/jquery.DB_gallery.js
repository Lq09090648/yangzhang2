/*********************************************************************************
gallery.js
*********************************************************************************/
;
(function($) {
    $.fn.DB_gallery = function(options) {
        var opt = {
            thumWidth: 110, //小图片的宽度
            thumGap: 8, //小图片之间的间隔距离
            thumMoveStep: 5, //移动的图片个数
            moveSpeed: 300, //移动速度
            fadeSpeed: 300, //退去的速度
            end: ''
        }
        $.extend(opt, options);
        return this.each(function() {
            var $this = $(this);
            var $imgSet = $this.find('.DB_imgSet');
            var $imgWin = $imgSet.find('.DB_imgWin');
            var $page = $this.find('.DB_page');
            var $pageCurrent = $page.find('.DB_current');
            var $pageTotal = $page.find('.DB_total');
            var $thumSet = $this.find('.DB_thumSet');
            var $thumMove = $thumSet.find('.DB_thumMove');
            var $thumList = $thumMove.find('li');
            var $thumLine = $this.find('.DB_thumLine');
            var $nextBtn = $this.find('.DB_nextBtn');
            var $prevBtn = $this.find('.DB_prevBtn');
            var $nextPageBtn = $this.find('.DB_nextPageBtn');
            var $prevPageBtn = $this.find('.DB_prevPageBtn');
            var objNum = $thumList.length;
            var currentObj = 0;
            var fixObj = 0;
            var currentPage = 0;
            var totalPage = Math.floor(objNum / opt.thumMoveStep);
            var oldImg;

            init();

            function init() {
                setInit();
                setMouseEvent();
                changeImg();
            }

            function setInit() {
                //初始化导航图片
                $thumMove.append($thumLine.get());
            }

            //鼠标点击小图片||点击nextBtn图片按钮||点击prevBtn图片按钮，显示对应得大图片
            function setMouseEvent() {
                $thumList.bind('click', function(e) {
                    //preventDefault方法(js自带的)将通知 Web 浏览器不要执行与事件关联的默认动作（如果存在这样的动作）
                    e.preventDefault();
                    currentObj = $(this).index();
                    changeImg();
                });
                $nextBtn.bind('click', function() {
                    currentObj++;
                    changeImg();
                    currentPage = Math.floor(currentObj / opt.thumMoveStep);
                    moveThum();

                });
                $prevBtn.bind('click', function() {
                    currentObj--;
                    changeImg();
                    currentPage = Math.floor(currentObj / opt.thumMoveStep);
                    moveThum();
                });
                $nextPageBtn.bind('click', function() {
                    currentPage++;
                    moveThum();
                });
                $prevPageBtn.bind('click', function() {
                    currentPage--;
                    moveThum();
                });

            }

            //
            function moveThum() {
                var pos = ((opt.thumWidth + opt.thumGap) * opt.thumMoveStep) * currentPage
                $thumMove.animate({
                    'left': -pos
                }, opt.moveSpeed);
                //
                setVisibleBtn();
            }

            //设置图片是否可见
            function setVisibleBtn() {
                $prevPageBtn.show();
                $nextPageBtn.show();
                $prevBtn.show();
                $nextBtn.show();
                if (currentPage == 0) $prevPageBtn.hide();
                if (currentPage == totalPage - 1 && totalPage != 1) $nextPageBtn.hide();
                if (currentObj == 0) $prevBtn.hide();
                if (currentObj == objNum - 1) $nextBtn.hide();
            }

            //改变显示的图片
            function changeImg() {
                if (oldImg != null) {
                    //设置图片显示的样式
                    $imgWin.css('background', 'url(' + oldImg + ') no-repeat');
                }
                //
                var $thum = $thumList.eq(currentObj)
                var _src = oldImg = $thum.find('a').attr('href');
                $imgWin.find('img').hide().attr('src', _src).fadeIn(opt.fadeSpeed);
                oldImg = _src

                //
                $thumLine.css({
                    'left': $thum.position().left
                })

                //设置显示的图片编号和总图片数
                $pageCurrent.text(currentObj + 1);
                $pageTotal.text(objNum);

                setVisibleBtn();
            }
        })
    }
})(jQuery)