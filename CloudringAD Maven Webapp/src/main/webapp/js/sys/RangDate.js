/*
*   Author:  TD
*       Date:  2011-6-1 Modified:2011-6-10
*         Des:  计算两日期的差，并按指定格式格式化，能自动倒计时
*   Version:  1.0
*/
(function RangeDate(dt1, dt2) {
    if (dt1 && (!this.add || !this.toString)) return new RangeDate.init(dt1, dt2);

    var metric = {};
    metric.s2Min = metric[0] = 60;
    metric.min2H = metric[1] = 60;
    metric.h2D = metric[2] = 24;
    metric.d2M = metric[3] = 0; //天到月的进制，会在特定的时候被重新评估
    metric.m2Y = metric[4] = 12;
    var month = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; //各个月的天数 ，其中的2月会在特定时候被重新评估

    //获得2月的天数
    var getFebDays = function (year) {
        if (year % 4) return 28; //不能被4整除，平年
        if (year % 100) return 29; //能被4整除，不能被100整除的，闰年
        if (year % 400) return 28; //能被4整除，能被100整除，不能但400整除的，平年
        return 29;
    };
    var isLastDayInMonth = function (d) {
        var m = d.getMonth();
        var m2 = getFebDays(d.getFullYear());
        return d.getDate() == (m == 1 ? m2 : month[d.getMonth()]);
    };
    var computeToDays = function (startM, year, count) {
        var ret = 0;
        for (var i = 0; i < count; i++, startM++) {
            if (startM > 12) { startM %= 12; year++; }
            var m2 = getFebDays(year);
            ret += startM == 2 ? m2 : month[startM - 1];
        }
        return ret;
    };
    //将日期转化成正常的正数形式
    var computeCor = function () {
        var o = ["this.second", "this.minute", "this.hour", "this.day", "this.month", "this.year"];
        var isValid = true;
        for (var i = 0; i < o.length; i++) {
            if (i < o.length - 1) {
                eval("if(" + o[i] + "< 0){" + o[i] + "+=" + metric[i] + ";" + o[i + 1] + "--;"
                + "}else if(" + o[i] + ">=" + metric[i] + "){" + o[i] + "-=" + metric[i] + ";" + o[i + 1] + "++;}");
            }
            if (i == 3)
                this.day = this.day < 0 ? 0 : this.day;
            eval('isValid=isValid&&' + o[i] + ">=0");
        }
        this.isValid = isValid;
        if (!this.isValid) {
            this.year = this.month = this.day = this.hour = this.minute = this.second = 0;
        }
        return this;
    };
    //计算日期差值
    var compute = function (bDate, sDate) {
        if (!sDate) { sDate = new Date(); } //传递一个参数，则当作与当前日期作比较
        if (typeof bDate === "string") {
            bDate = new Date(bDate.replace(/-/g, "/")); //不能从 - 型字串转化日期
        }
        if (typeof sDate === "string") {
            sDate = new Date(sDate.replace(/-/g, "/")); //不能从 - 型字串转化日期
        }
        this.bDate = bDate; this.sDate = sDate;
        //bDate较大日期，sDate较小日期
        if (bDate - sDate < 0) {
            //var temp = bDate;
            //bDate = sDate;
            //sDate = temp;update by hejp 选择的日期小于当前日期为什么要交换，搞不懂。
        } else if (bDate - sDate == 0) {
            return this;
        }
        month[1] = getFebDays(bDate.getFullYear()); /*重评估二月的天数*/
        metric.d2M = metric[3] = month[bDate.getMonth() ? bDate.getMonth() - 1 : 11]; //重评估月的进制(大日期上个月的天数)。如果是1月，则索引为0，获得12月的天数
        this.year = bDate.getFullYear() - sDate.getFullYear();
        this.month = bDate.getMonth() - sDate.getMonth();
        this.day = isLastDayInMonth(bDate) && isLastDayInMonth(sDate) ? 0 : bDate.getDate() - sDate.getDate();
        this.hour = bDate.getHours() - sDate.getHours();
        this.minute = bDate.getMinutes() - sDate.getMinutes();
        this.second = bDate.getSeconds() - sDate.getSeconds();

        //整理日期
        return computeCor.call(this);
    };

    RangeDate.init = function (d1, d2) {
        this.year = 0;
        this.month = 0;
        this.day = 0;
        this.hour = 0;
        this.minute = 0;
        this.second = 0;

        this.format = "";

        compute.call(this, d1, d2); //计算
    };
    var getSameChar = function (c, length) {
        if (typeof c !== 'string') return;
        c = c.match(/^\w/i);
        var result = "";
        for (var i = 0; i < length - c.length; i++) {
            result += c;
        }
        return result;
    };
    var fullStringWith = function (str, length, sep) {
        if (typeof str == 'undefined') return;
        str = str.toString();
        if (!length) length = 4;
        if (!sep) sep = "0"; //默认 '0'
        if (str.length >= length) return str;
        var fill = getSameChar(sep, str.length - length);
        return fill + str;
    };
    var pt = RangeDate.init.prototype;
    pt.toString = function (format, isOri) {//format为显示格式，如果不传递此参数，则采用this.format;isOri是否显示成真实时间
        if (format.toString() == "d Day(s)") {
            format = "dd Day(s)";
        }
        else if (format.toString() == "d Day(s) h Hour(s) m Minute(s)") {
            format = "dd Day(s) hh Hour(s) mm Minute(s)"
        }
        else if (format.toString() == "d Day(s) h Hour(s) m Minute(s) s Second(s)") {
            format = "dd Day(s) hh Hour(s) mm Minute(s) ss Second(s)";
        }
        if (!format) { format = this.format; }
        if (!format) { format = /*yyyy年M月*/"d天h小时m分钟s秒"; }
        this.format = format;
        //只显示天数，专为按天倒计时设计
        if (format.match(/^d+[^hms]*$/)/**/) {
            d = compute.call(this, this.bDate.toDateString(), new Date().toDateString()).day; //使用较大日期为目标日期，忽略天下面的单位来计算
        }
        var y = this.year, M = this.month, d = this.day,
		h = this.hour, m = this.minute, s = this.second;
        var o = { MM: M, dd: d, hh: h, mm: m, ss: s };
        
        d += computeToDays(this.sDate.getMonth() + 1, this.sDate.getFullYear(), M); //转换成天
        if (format.match(/m+[^s]*$/)/*精确到分*/ && this.second) { m++; }
        //年数格式
        var reg;
        if (reg = format.match(/y+/)) {
            y = y.toString();
            y = y.substr(y.length - reg[0].length, reg[0].length);
            //format = format.replace(reg[0], y);
        }
        if (!isOri) {
            if (format.indexOf("dd Day(s)") == 0) {
                o = { MM: M, dd: d, hh: h, mm: m, ss: s };
            }
            else {
                o = { M: M, d: d, h: h, m: m, s: s };
            }
        }
        for (var k in o) {
            if (reg = format.match(new RegExp(k + "+"))) {
                o[k] = fullStringWith(o[k], reg[0].length);
                format = format.replace(reg[0], o[k]);
            }
        }
        return format; //.replace(/\b0+[^\d]+(?![:\b])/g, ""); //去除数字为0的单位
    };
    pt.add = function (date) {
        if (typeof date == 'string') {
            date = new Date(date.replace("-", "/"));
        }
        this.year += date.getFullYear();
        this.month += date.getMonth() + 1;
        this.day += date.getDate();
        this.hour += date.getHours();
        this.minute += date.getMinutes();
        this.second += date.getSeconds();
        return computeCor.call(this);
    };
    pt.addSecond = function (s) {
        this.second += parseInt(s);
        return computeCor.call(this);
    };
    pt.addMinute = function (min) {
        this.minute += parseInt(min);
        return computeCor.call(this);
    };
    pt.addHour = function (h) {
        this.hour += parseInt(h);
        return computeCor.call(this);
    };
    pt.addDay = function (d) {
        this.day += parseInt(d);
        return computeCor.call(this);
    };
    pt.addMonth = function (m) {
        this.month += parseInt(m);
        return computeCor.call(this);
    };
    pt.addYear = function (y) {
        this.year += parseInt(y);
        return computeCor.call(this);
    };

    //自动倒计时
    pt.counterDown = function (obj, format) {//obj为显示当前倒计时的dom元素
        var start = function () {
            this.addSecond(-1);
            computeCor.call(this);
            if (window.counterDown && !this.isValid) clearInterval(window.counterDown); //倒计到0秒时中止计时
            if (typeof obj == 'string') obj = document.getElementById(obj);
            if (!obj) return;
            obj.title = this.toString("y年M月d天h小时m分钟s秒", true);
            obj.innerText = this.toString(format); //显示倒计时
        };
        var range = 1; //默认为1秒	
        var self = this;
        window.counterDown = setInterval(function () { start.call(self); }, range * 1000); //启用定时器
        return self;
    };

    window.RangeDate = RangeDate;
})();