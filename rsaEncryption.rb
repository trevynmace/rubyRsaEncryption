# base used in modular exponentiation
  def base(n, b)
    q = n
    a = []
    while q != 0
      a.push(q % b)
      q = (q/b).floor
    end
    return a
  end

# modular exponentiation
  def mod(b, n, m)
    a = base(n, 2)
    x = 1
    pow = b % m
    for i in (0..a.length)
      if (a[i] == 1)
        x = (x * pow) % m
      end
      pow = (pow * pow) % m
    end
    return x
  end

# def mod(base, power, mod)
#   res = 1
#   while power > 0
#     res = (res * base) % mod if power & 1 == 1
#     base = base ** 2 % mod
#     power >>= 1
#   end
#   res
# end

  def encrypt(message, e, n)
    #FIXME: need to convert string to integers
    # when converting to ascii, pad with 0 if only size of 2, keep everything 3 characters long.
    # when decrypting, if starts with 0, remove the 0 and convert back to character,
    # that way decrypting can get every 3 characters no matter what
    encryptedList = []
    m = s_to_n(message)
    for i in (0..m.length)
      encryptedList.push(mod(m[i].to_i, e, n))
      encryptedList.push("/")
    end
    encryptedList
  end

  def decrypt(c, n, d)
    m = mod(c, d, n)
    # n_to_s(m)
  end

# implement converting rules for string to number and number to string
  def n_to_s(n)
    s = ""
    while(n > 0)
      s = ( n & 0xFF ).chr + s
      n >>= 8
    end
    #FIXME: make sure to return a string
    s
  end

  def s_to_n(s)
    n = []
    s.each_byte do |b|
      n.push(b)
    end
    n
  end

  def greatestCommonDivisor(a, b)
    if a % b == 0
      return [0,1]
    end
    x, y = greatestCommonDivisor(b, a % b)
    [y, x - y * (a / b)]
  end

  def calculateD(p, q, e)
    t = totient(p, q)
    x, y = greatestCommonDivisor(e, t)
    if x < 0
      x += t
    end
    x
  end

  def totient(p, q)
    (p - 1) * (q - 1)
  end

e = 17
p = 71
q = 67
n = p * q
d = calculateD(p, q, e)

# FIXME: change this to the correct message
m = "I hope this works"

puts "public exponent    (e): " + e.to_s
puts "public modulus     (n): " + n.to_s
puts "private key exp    (d): " + d.to_s + "\n\n"

puts "Message            (m): " + m.to_s + "\n"

encryptedMessage = encrypt(m, e, n)
encryptedMessageString = ""
for i in 0..(encryptedMessage.length - 1)
  encryptedMessageString += encryptedMessage[i].to_s
end
puts "Encrypted          : " + encryptedMessageString.to_s

#FIXME: uncomment for decryption
# decryptedMessage = decrypt(encryptedMessage, n, d)
# puts "Decrypted          : " + decryptedMessage.to_s


# c is the encrypted message
# m^e mod n = c
# c^d mod n = m


# the number being put into mod() has to be less than n to work properly
# put the values through mod() by themselves and push to a list

# problem now is the separator between numbers representing letters. can't use a number combination because there's always a chance that it will be somewhere else