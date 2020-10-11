#!/usr/bin/ruby

class BigNumber
    attr_accessor :eightOfNum, :num
    def initialize(x="")
        @eightOfNum = Array.new
        @num = x
        i = x.length
        while true
            if i <= 0
                break
            elsif i < 8
                @eightOfNum.push(x[0..i-1])
                break
            end
            @eightOfNum.push(x[i-8..i-1])
            i-= 8
        end
    end

    def getResult(arr)
        res = ""
        i = 0 
        while i < arr.length 
            res = arr[i].to_s.rjust(8, "0").concat(res)
            i+=1
        end
        return res.to_i.to_s
    end

    def +(otherNum)
        res = Array.new 
        g = 0
        i = 0
        while true
            if g == 0 and i >= @eightOfNum.length and i >= otherNum.eightOfNum.length
                break
            end
            x = g
            if i < @eightOfNum.length
                x += @eightOfNum[i].to_i
            end
            if i < otherNum.eightOfNum.length
                x += otherNum.eightOfNum[i].to_i
            end
            g = x/100000000
            # res = (x%100000000).to_s.concat(res)
            res.push(x%100000000)
            i+=1
        end
        return getResult(res) 
    end

    def <(otherNum)
        if @eightOfNum.length != otherNum.eightOfNum.length
            return @eightOfNum.length < otherNum.eightOfNum.length
        end
        i = @eightOfNum.length - 1 
        while i >= 0
            if @eightOfNum[i].to_i != otherNum.eightOfNum[i].to_i
                return @eightOfNum[i].to_i < otherNum.eightOfNum[i].to_i
            end
            i-= 1
        end
        return false
    end

    def -(otherNum)
        res = Array.new 
        bigNum = Array.new 
        smallNum = Array.new 
        sign = false

        if self < otherNum
            bigNum = otherNum.eightOfNum
            smallNum = @eightOfNum
            sign = true 
        else
            bigNum = @eightOfNum
            smallNum = otherNum.eightOfNum
        end

        g = 0
        i = 0
        while i < bigNum.length
            if i < smallNum.length
                if bigNum[i].to_i - g < smallNum[i].to_i
                    temp = bigNum[i].to_i + 100000000 - smallNum[i].to_i - g
                    # res = temp.to_s.concat(res)
                    res.push(temp)
                    g = 1
                elsif bigNum[i].to_i - g > smallNum[i].to_i
                    temp = bigNum[i].to_i - smallNum[i].to_i - g
                    # res = temp.to_s.concat(res.rjust(8, "0"))
                    res.push(temp)
                    g = 0
                else
                    if i < bigNum.length - 1
                        temp = "00000000"
                        # res = temp.concat(res.rjust(8, "0"))
                        res.push(temp)
                    else
                        break
                    end
                end
            else
                temp = bigNum[i].to_i - g
                g = 0
                # res = temp.to_s.concat(res.rjust(8, "0"))
                res.push(temp)
            end
            i+= 1
        end

        result = getResult(res)

        if sign
            singal = "-"
            result = singal.concat(result)
        end

        return result
    end

    def *(otherNum)
       res = ""

       for i in 0..@eightOfNum.length - 1
            for j in 0..otherNum.eightOfNum.length - 1
                add = BigNumber.new(res) 
                temp = BigNumber.new()

                t = @eightOfNum[i].to_i * otherNum.eightOfNum[j].to_i
                for k in 0..i+j-1
                    temp.eightOfNum.push("00000000")
                end

                begin
                    temp.eightOfNum.push((t % 100000000).to_s)
                    t /= 100000000
                end while t > 0

                res = add + temp
            end
       end
       return res.to_i.to_s
    end

    def /(otherNum)
        if otherNum.num.to_i == 0
            return "除0错误"
        end
        if self < otherNum
            return "0";
        elsif @num.to_i == otherNum.num.to_i
            return "1"
        else
            flen = @eightOfNum.length - otherNum.eightOfNum.length
            temp = Array.new
            d = BigNumber.new()
            for i in flen..@eightOfNum.length-1
                d.eightOfNum.push(@eightOfNum[i])
            end
            if d < otherNum
                d.eightOfNum.push("0")
                i = d.eightOfNum.length - 2
                while i >= 0
                    d.eightOfNum[i+1] = d.eightOfNum[i]
                    i-= 1;
                end
                flen-= 1
                d.eightOfNum[0] = @eightOfNum[flen]
            end

            times = flen + 1
            while times > 0
                n = 0
                # while otherNum < d
                #     res = d - otherNum 
                #     n+=1
                #     if res.to_i == otherNum.num.to_i 
                #         n+=1
                #         d = BigNumber.new("0")
                #         break
                #     end
                #     d = BigNumber.new(res)
                # end
                if otherNum < d 
                    n = getResult(d.eightOfNum).to_i / getResult(otherNum.eightOfNum).to_i
                    res = getResult(d.eightOfNum).to_i % getResult(otherNum.eightOfNum).to_i
                    d = BigNumber.new(res.to_s)
                end
                temp.push(n)
                if flen > 0
                    if d.num.to_i > 0
                        d.eightOfNum.push("0")
                        i = d.eightOfNum.length - 2
                        while i >= 0
                            d.eightOfNum[i+1] = d.eightOfNum[i]
                            i-=1
                        end
                        flen-=1
                        d.eightOfNum[0] = @eightOfNum[flen]
                    else
                        flen-=1
                        d.eightOfNum[0] = @eightOfNum[flen]
                    end
                end
                times-= 1
            end

            ans = ""
            i = temp.length-1
            while i >= 0
                ans = temp[i].to_s.rjust(8, "0").concat(ans)
                i-=1
            end
            
            return ans.to_i.to_s
        end
    end

end

while true
    puts "输入计算式"
    str = gets.chomp

    if str == "exit"
        break
    end

    op = str.gsub /\d/, ""
    leftNum = str.sub /[-+*\/]\d+$/, ""
    rightNum = str.sub /^\d+[-+*\/]/, ""

    a = BigNumber.new(leftNum)
    b = BigNumber.new(rightNum)

    if op == "-"
        puts str + " = #{a - b}"
    elsif op == "+"
        puts str + " = #{a + b}"
    elsif op == "*"
        puts str + " = #{a * b}"
    elsif op == "/"
        puts str + " = #{a / b}"
    else
        puts "该运算符不支持"
    end
end
