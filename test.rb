# a = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " "]
# b = []
#
# for i in (0..a.length)
#   element = a[i]
#   elementOrd = element.to_s.ord
#   # puts "element: " + element.to_s
#   # puts "elementOrd: " + elementOrd.to_s
#   # b.push((a[i]).to_s.ord)
# end

# puts b.to_s


# def s_to_n(s)
#   n = []
#   s.each_byte do |b|
#     n.push((13 * b).to_s)
#   end
#   n
# end
#
# def n_to_s(s)
#   m = ""
#   s.each do |b|
#     m += (b.to_i / 13).chr
#   end
#   m
# end
#
# encrypted = s_to_n "The Queen Can't Roll When Sand is in the Jar"
#
# puts encrypted.to_s
#
# decrypted = n_to_s encrypted
#
# puts decrypted.to_s

puts "thing: " + (065.chr).to_s