Batman.mixin Batman.Filters,

  startText: (str_start)->
    now = moment.utc()
    console.log(now)
    start = moment(str_start)
    console.log(start)
    "#{start.from(now)}"

class Dashing.ExchangeCalendar extends Dashing.Widget