#!/usr/bin/ruby

def isLeap(year)
    return ((year%100 == 0 and year%400 == 0) or (year%100 != 0 and year%4 == 0)) 
end

def getWeek(year=2020, month=10)
    daySum = Array[0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]

    sum = daySum[month-1] + (year - 1900)*365
    if month > 2 and isLeap(year)
        sum += 1
    end
    for i in (1900..year-1)
        if isLeap(i)
            sum += 1
        end
    end

    return (sum+1)%7
end

def printCalender(year=2020, month=10)
    days = Array[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    if isLeap(year) 
        days[1] = 29
        puts "#{year}是润年, 该月日历为"
    else
        puts "#{year}不是润年, 该月日历为"
    end

    startDay = getWeek(year, month)
    monthDay = days[month-1]
    pstartDay = 1

    puts "Sun  Mon  Tue  Wed  Thu  Fri  Sat"
    for i in (1..42)
        if startDay > 0
            print "   "
            startDay -= 1 
        else
            if pstartDay <= monthDay
                s = pstartDay.to_s.rjust(3, ' ')
                print s
                pstartDay += 1
            else
                print "   "
            end
        end

        if i%7 == 0
            print "\n"
        else
            print "  "
        end
    end
end

while true
    time = gets.chomp

    if time == "exit"
        break
    elsif !(time =~ /\d+-\d+/)
        puts "请输入正确格式的日期如2020-10"
        next
    end

    year = time.sub /-.+$/, ""
    month = time.sub /^.*-/, ""

    if year.to_i < 1900
        puts "该日历目前不支持1900年以前的日期"
        next
    end

    printCalender(year.to_i, month.to_i)
end