var Graph = { init: function() {
    var chartParser = (function() {
      function _uniqueCompact(array) {
        var unique = [];
        for (var i = 0; i < array.length; i++) {
            if (unique.indexOf(array[i]) == -1) {
                unique.push(array[i]);
            }
        }
        return unique.filter(function(n){return n});
      }

      function _moneyCompact(array){
        var total = 0
        var amounts =  array.filter(function(n){return n});
        var int_amounts = $.map(amounts, function(v,i){return parseInt(v)})
        for(var i in int_amounts) { total += int_amounts[i]; }
        return total
      }

      return {
        uniqueCompact: _uniqueCompact,
        moneyCompact: _moneyCompact
      }
    }());


    var dates = chartParser.uniqueCompact($('.date').text().split('Date: '))

    function ChartPoint(date){
      this.date = date
      this.revenue = getRevenue(this.date)

      function getRevenue(date){
        return chartParser.moneyCompact($("." + date).text().split('Amount: $'))
      }
    }

    var dataGenerator = (function() {
      function data(){
        return $.map(dates, function(v,i){
          return new ChartPoint(v)
        })
      }

      function _labels() {
        return $.map(data(), function(v,i){
          return v.date
        }).reverse()
      }

      function _values(){
        return $.map(data(), function(v,i){
          return v.revenue
        }).reverse()
      }
      return {
        labels: _labels,
        numbers: _values
      }
    }());

    var ctx = $("#myChart").get(0).getContext("2d");
    var data = {
      labels : dataGenerator.labels(),
      datasets : [
        {
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : dataGenerator.numbers()
        }
      ]
    }
    var myChart = new Chart(ctx).Line(data);
  }
}