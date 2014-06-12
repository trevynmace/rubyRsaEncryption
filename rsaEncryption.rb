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

  def n_to_s( n )
    s = ""
    while( n > 0 )
      s = ( n & 0xFF ).chr + s
      n >>= 8
    end
    s
  end

  def s_to_n( s )
    n = 0
    s.each_byte do |b|
      n = n * 256 + b
    end
    n
  end

  def extended_gcd( a, b )
    return [0,1] if a % b == 0
    x, y = extended_gcd( b, a % b )
    [y, x - y * (a / b)]
  end

  def get_d(p, q, e)
    t = phi( p, q )
    x, y = extended_gcd( e, t )
    x += t if x < 0
   x
  end

  def phi( p, q )
    (p - 1) * (q - 1)
  end


e = 17
p = 71
q = 67
n = p * q
d = get_d(p, q, e)

m = 65

puts "public exponent    : " + e.to_s
puts "public modulus     : " + n.to_s
puts "private key exp    : " + d.to_s

puts ""
puts "Message        : %s" % m
puts ""

c = encrypt( m, e, n )

puts "Encrypted      : " + c.to_s
puts ""
puts "Decrypted      : " + decrypt( c, n, d ).to_s