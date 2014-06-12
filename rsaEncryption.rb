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

  def encrypt( m, e, n )
    # m = s_to_n( m )
    mod( m, e, n )
  end


  def decrypt( c, n, d )
    m = mod( c, d, n )
    # n_to_s( m )
  end

# implement converting rules for string to number and number to string
  # def n_to_s( n )
  #   s = ""
  #   while( n > 0 )
  #     s = ( n & 0xFF ).chr + s
  #     n >>= 8
  #   end
  #   s
  # end
  #
  # def s_to_n( s )
  #   n = 0
  #   s.each_byte do |b|
  #     n = n * 256 + b
  #   end
  #   n
  # end

  def greatestCommonDivisor(a, b)
    if a % b == 0
      return [0,1]
    end
    x, y = greatestCommonDivisor(b, a % b)
    [y, x - y * (a / b)]
  end

  def get_d(p, q, e)
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
d = get_d(p, q, e)

# change this to the correct message
m = 65

puts "public exponent    : " + e.to_s
puts "public modulus     : " + n.to_s
puts "private key exp    : " + d.to_s + "\n\n"

puts "Message            : " + m.to_s + "\n\n"

encryptedMessage = encrypt( m, e, n )
puts "Encrypted          : " + encryptedMessage.to_s + "\n"

decryptedMessage = decrypt(encryptedMessage, n, d)
puts "Decrypted          : " + decryptedMessage.to_s