$(document).ready(function() {
    $('#calendar').fullCalendar({
        events: '/events.json',
        // 土曜、日曜を表示
        weekends: true,
        timeFormat: ' ',

		monthNames: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
		monthNamesShort: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
		dayNames: ['日曜日','月曜日','火曜日','水曜日','木曜日','金曜日','土曜日'],
		dayNamesShort: ['日曜','月曜','火曜','水曜','木曜','金曜','土曜'],

        // タイトルの書式
        titleFormat: {
            month: 'YYYY年M月'
        },
        //eventClick: function (event) {
        //    window.location.href = "/expenses/" + event.id + "/edit";
        //},
        //イベントじゃないところをクリックしたとき(日をクリックしたとき)に実行
        
        // 高さ(px)
        height: 550,
        // コンテンツの高さ(px)
        contentHeight: 500,
        // 週モード (fixed, liquid, variable)
        weekMode: 'liquid',
        header: {
            // title, prev, next, prevYear, nextYear, today
            left: 'prev,today,next',
            center: 'title',
            right: 'prevYear,nextYear'
        },
        // ボタン文字列
        buttonText: {
            prev:     '先月',
            next:     '翌月',
            prevYear: '前年',  // <<
            nextYear: '翌年',  // >>
            today:    '今日'
        },
        dayClick: function(date){ 
        	var setdate = new Date(date);
        	var setmonth = setdate.getMonth() + 1;
        	var setmonthzero = ("0" + setmonth).slice(-2);
        	var setdatezero = ("0" + setdate.getDate()).slice(-2);

            window.location.href = "/expenses/new?day=" + setdate.getFullYear()  + setmonthzero + setdatezero;
		},
    });
});