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

# function to encrypt the message to a number
def encrypt(message, e, n)
  encryptedList = []
  m = stringToNum(message)
  for i in (0..m.length)
    encryptedList.push(mod(m[i].to_i, e, n))
    encryptedList.push("0320")
  end
  encryptedList
end

# function to decrypt the number message back to a string
def decrypt(c, n, d)
  list = c.split("0320").map(&:to_i)
  intList = []
  for i in 0..list.length
    intList.push(mod(list[i].to_i, d, n))
  end
  returnString = ""
  for i in 0..intList.length
    returnString += numToString(intList[i].to_i)
  end
  returnString
end

# function to convert numbers to strings
def numToString(n)
  s = ""
  while(n > 0)
    s = (n & 0xFF).chr + s
    n >>= 8
  end
  s
end

# function to convert strings to numbers
def stringToNum(s)
  n = []
  s.each_byte do |b|
    n.push(b)
  end
  n
end

# function to get the greatest common divisor for calculating d
def greatestCommonDivisor(a, b)
  if a % b == 0
    return [0,1]
  end
  x, y = greatestCommonDivisor(b, a % b)
  [y, x - y*(a / b)]
end

# function to calculate the value of the private key exponent
def calculateD(p, q, e)
  t = totient(p, q)
  x, y = greatestCommonDivisor(e, t)
  if x < 0
    x += t
  end
  x
end

# function to calculate the totient of n
def totient(p, q)
  (p - 1) * (q - 1)
end

# given variables
e = 17
p = 71
q = 67
n = p * q
d = calculateD(p, q, e)
m = "The Queen Can't Roll When Sand is in the Jar"

puts "public exponent    (e): " + e.to_s
puts "public modulus     (n): " + n.to_s
puts "private key exp    (d): " + d.to_s
puts "Message            (m): " + m.to_s + "\n\n"

encryptedMessage = encrypt(m, e, n)
encryptedMessageString = ""
for i in 0..(encryptedMessage.length - 1)
  encryptedMessageString += encryptedMessage[i].to_s
end
puts "Encrypted             : " + encryptedMessageString.to_s

decryptedMessage = decrypt(encryptedMessageString, n, d)
puts "Decrypted             : " + decryptedMessage.to_s