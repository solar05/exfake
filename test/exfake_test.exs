defmodule ExfakeTest do
  use ExUnit.Case

  describe "name_prefix/0" do
    test "returns a known prefix" do
      assert Exfake.name_prefix() in ["Mr.", "Mrs.", "Ms.", "Miss", "Dr.", "Prof."]
    end
  end

  describe "job_title/0" do
    test "returns a non-empty string starting with a capital letter" do
      title = Exfake.job_title()
      assert is_binary(title)
      assert title =~ ~r/^[A-Z]/
    end
  end

  describe "first_name/0" do
    test "returns a non-empty string" do
      name = Exfake.first_name()
      assert is_binary(name)
      assert String.length(name) > 0
    end
  end

  describe "last_name/0" do
    test "returns a non-empty string" do
      name = Exfake.last_name()
      assert is_binary(name)
      assert String.length(name) > 0
    end
  end

  describe "person/0" do
    test "returns two words separated by a space" do
      assert Exfake.person() =~ ~r/^\S+ \S+$/
    end
  end

  describe "phone_number/0" do
    test "returns a string containing digits" do
      assert Exfake.phone_number() =~ ~r/\d/
    end
  end

  describe "word/0" do
    test "returns a non-empty lowercase string" do
      word = Exfake.word()
      assert is_binary(word)
      assert String.length(word) > 0
      assert word == String.downcase(word)
    end
  end

  describe "sentence/1" do
    test "is capitalized and ends with a period" do
      s = Exfake.sentence()
      assert String.ends_with?(s, ".")
      assert s =~ ~r/^[A-Z]/
    end

    test "contains the specified number of words" do
      words = Exfake.sentence(4) |> String.trim_trailing(".") |> String.split(" ")
      assert length(words) == 4
    end

    test "raises for count <= 1" do
      assert_raise FunctionClauseError, fn -> Exfake.sentence(1) end
    end
  end

  describe "paragraphs/2" do
    test "returns the correct number of sentences" do
      para = Exfake.paragraphs(3)
      # Each sentence ends with ".", split on ". " leaves last with "." attached
      parts = String.split(para, ". ")
      assert length(parts) == 3
    end

    test "raises when limit < 2" do
      assert_raise FunctionClauseError, fn -> Exfake.paragraphs(3, 1) end
    end
  end

  describe "language_code/0" do
    test "returns a 2-letter lowercase code" do
      assert Exfake.language_code() =~ ~r/^[a-z]{2}$/
    end
  end

  describe "company_suffix/0" do
    test "returns one of the known suffixes" do
      assert Exfake.company_suffix() in ["Inc", "and Sons", "LLC", "Group"]
    end
  end

  describe "catch_phrase/0" do
    test "returns a non-empty string" do
      phrase = Exfake.catch_phrase()
      assert is_binary(phrase)
      assert String.length(phrase) > 0
    end
  end

  describe "bs/0" do
    test "returns a non-empty string" do
      bs = Exfake.bs()
      assert is_binary(bs)
      assert String.length(bs) > 0
    end
  end

  describe "company_name/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.company_name())
    end
  end

  describe "currency/0" do
    test "returns a list of exactly 3 strings" do
      currency = Exfake.currency()
      assert is_list(currency)
      assert length(currency) == 3
      Enum.each(currency, &assert(is_binary(&1)))
    end
  end

  describe "xss_string/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.xss_string())
    end
  end

  describe "xss_file/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.xss_file())
    end
  end

  describe "ipv4/0" do
    test "returns 4 dot-separated octets all in 0..255" do
      parts = Exfake.ipv4() |> String.split(".")
      assert length(parts) == 4

      Enum.each(parts, fn p ->
        n = String.to_integer(p)
        assert n >= 0 and n <= 255
      end)
    end

    test "first octet is never zero" do
      Enum.each(1..20, fn _ ->
        first = Exfake.ipv4() |> String.split(".") |> hd()
        assert String.to_integer(first) >= 1
      end)
    end
  end

  describe "ipv6/0" do
    test "returns 8 colon-separated hex groups all in 0..65535" do
      parts = Exfake.ipv6() |> String.split(":")
      assert length(parts) == 8

      Enum.each(parts, fn p ->
        n = String.to_integer(p, 16)
        assert n >= 0 and n <= 65_535
      end)
    end
  end

  describe "mac/0" do
    test "returns 6 colon-separated zero-padded hex octets" do
      parts = Exfake.mac() |> String.split(":")
      assert length(parts) == 6

      Enum.each(parts, fn p ->
        assert String.length(p) == 2
        n = String.to_integer(p, 16)
        assert n >= 0 and n <= 255
      end)
    end
  end

  describe "http_code/0" do
    test "returns an integer in the 1xx–5xx range" do
      code = Exfake.http_code()
      assert is_integer(code)
      assert code >= 100 and code < 600
    end
  end

  describe "http_code/1" do
    test ":info returns a 1xx code" do
      assert Exfake.http_code(:info) in [100, 101, 102, 103]
    end

    test ":success returns a 2xx code" do
      code = Exfake.http_code(:success)
      assert code >= 200 and code < 300
    end

    test ":redirection returns a 3xx code" do
      code = Exfake.http_code(:redirection)
      assert code >= 300 and code < 400
    end

    test ":client_error returns a 4xx code" do
      code = Exfake.http_code(:client_error)
      assert code >= 400 and code < 500
    end

    test ":server_error returns a 5xx code" do
      code = Exfake.http_code(:server_error)
      assert code >= 500 and code < 600
    end
  end

  describe "email/0" do
    test "matches user@domain.tld format" do
      assert Exfake.email() =~ ~r/^[a-z]+@[a-z.]+\.[a-z]+$/
    end
  end

  describe "domain/0" do
    test "starts with www. and contains a TLD" do
      domain = Exfake.domain()
      assert String.starts_with?(domain, "www.")
      assert domain =~ ~r/\.[a-z]+$/
    end
  end

  describe "url/0" do
    test "starts with http:// or https://" do
      url = Exfake.url()
      assert String.starts_with?(url, "http://") or String.starts_with?(url, "https://")
    end
  end

  describe "zip_code/0" do
    test "matches 5-digit or ZIP+4 format" do
      assert Exfake.zip_code() =~ ~r/^\d{5}(-\d{4})?$/
    end
  end

  describe "boolean/0" do
    test "returns true or false" do
      result = Exfake.boolean()
      assert result == true or result == false
    end
  end

  describe "integer/2" do
    test "returns an integer within the given range" do
      n = Exfake.integer(1, 100)
      assert is_integer(n)
      assert n >= 1 and n <= 100
    end

    test "raises for an inverted range" do
      assert_raise FunctionClauseError, fn -> Exfake.integer(100, 1) end
    end
  end

  describe "float/2" do
    test "returns a float within the given range" do
      f = Exfake.float(1.0, 10.0)
      assert is_float(f)
      assert f >= 1.0 and f <= 10.0
    end

    test "accepts integer bounds" do
      f = Exfake.float(0, 1)
      assert is_float(f)
      assert f >= 0.0 and f < 1.0
    end
  end

  describe "uuid/0" do
    test "matches UUID v4 format" do
      assert Exfake.uuid() =~
               ~r/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
    end

    test "generates unique values" do
      uuids = Enum.map(1..20, fn _ -> Exfake.uuid() end)
      assert length(Enum.uniq(uuids)) == 20
    end
  end

  describe "rgb_color/0" do
    test "returns a 3-tuple of integers in 0..255" do
      {r, g, b} = Exfake.rgb_color()

      for v <- [r, g, b] do
        assert is_integer(v)
        assert v in 0..255
      end
    end
  end

  describe "slug/0" do
    test "matches word-word-number pattern" do
      assert Exfake.slug() =~ ~r/^[a-z]+-[a-z]+-\d+$/
    end
  end

  describe "semver/0" do
    test "matches MAJOR.MINOR.PATCH format" do
      assert Exfake.semver() =~ ~r/^\d+\.\d+\.\d+$/
    end
  end

  describe "port/0" do
    test "returns an integer in 1..65535" do
      p = Exfake.port()
      assert is_integer(p)
      assert p in 1..65_535
    end
  end

  describe "hex_color/0" do
    test "matches #RRGGBB uppercase hex format" do
      assert Exfake.hex_color() =~ ~r/^#[0-9A-F]{6}$/
    end
  end

  describe "date/0" do
    test "returns a Date struct" do
      assert %Date{} = Exfake.date()
    end
  end

  describe "past_date/1" do
    test "returns a date strictly before today" do
      assert Date.compare(Exfake.past_date(), Date.utc_today()) == :lt
    end

    test "respects the max days bound" do
      max_days = 10
      date = Exfake.past_date(max_days)
      diff = Date.diff(Date.utc_today(), date)
      assert diff >= 1 and diff <= max_days
    end

    test "raises for non-positive days" do
      assert_raise FunctionClauseError, fn -> Exfake.past_date(0) end
    end
  end

  describe "time/0" do
    test "returns a Time struct" do
      assert %Time{} = Exfake.time()
    end

    test "hour, minute, second are in valid ranges" do
      t = Exfake.time()
      assert t.hour in 0..23
      assert t.minute in 0..59
      assert t.second in 0..59
    end
  end

  describe "datetime/0" do
    test "returns a DateTime struct" do
      assert %DateTime{} = Exfake.datetime()
    end

    test "is in UTC timezone" do
      assert Exfake.datetime().time_zone == "Etc/UTC"
    end
  end

  describe "timezone/0" do
    test "returns a non-empty string" do
      tz = Exfake.timezone()
      assert is_binary(tz)
      assert String.length(tz) > 0
    end

    test "contains a slash (IANA region/city format)" do
      assert String.contains?(Exfake.timezone(), "/")
    end
  end

  describe "future_date/1" do
    test "returns a date strictly after today" do
      assert Date.compare(Exfake.future_date(), Date.utc_today()) == :gt
    end

    test "respects the max days bound" do
      max_days = 10
      date = Exfake.future_date(max_days)
      diff = Date.diff(date, Date.utc_today())
      assert diff >= 1 and diff <= max_days
    end

    test "raises for non-positive days" do
      assert_raise FunctionClauseError, fn -> Exfake.future_date(0) end
    end
  end

  describe "price/2" do
    test "returns a float in the default range" do
      p = Exfake.price()
      assert is_float(p)
      assert p >= 1.0 and p <= 1000.0
    end

    test "respects a custom range" do
      p = Exfake.price(5.0, 10.0)
      assert p >= 5.0 and p <= 10.0
    end

    test "is rounded to 2 decimal places" do
      p = Exfake.price()
      assert Float.round(p, 2) == p
    end
  end

  describe "ssn/0" do
    test "matches XXX-XX-XXXX format" do
      assert Exfake.ssn() =~ ~r/^\d{3}-\d{2}-\d{4}$/
    end

    test "area code is in valid range 001-899" do
      area = Exfake.ssn() |> String.split("-") |> hd() |> String.to_integer()
      assert area in 1..899
    end
  end

  describe "tax_id/0" do
    test "matches XX-XXXXXXX format" do
      assert Exfake.tax_id() =~ ~r/^\d{2}-\d{7}$/
    end
  end

  describe "credit_card_type/0" do
    test "returns a known card brand" do
      assert Exfake.credit_card_type() in [
               "Visa",
               "Mastercard",
               "American Express",
               "Discover",
               "JCB"
             ]
    end
  end

  describe "credit_card_number/0" do
    test "is 15 or 16 digits" do
      assert Exfake.credit_card_number() =~ ~r/^\d{15,16}$/
    end

    test "passes the Luhn check" do
      Enum.each(1..10, fn _ ->
        assert luhn_valid?(Exfake.credit_card_number())
      end)
    end
  end

  describe "city/0" do
    test "returns a non-empty string" do
      city = Exfake.city()
      assert is_binary(city)
      assert String.length(city) > 0
    end
  end

  describe "street_address/0" do
    test "starts with a house number" do
      assert Exfake.street_address() =~ ~r/^\d+\s/
    end

    test "contains a street type" do
      types = ~w(Street Avenue Boulevard Drive Court Lane Way Place Road Circle)
      parts = Exfake.street_address() |> String.split(" ")
      assert List.last(parts) in types
    end
  end

  describe "state/0" do
    test "returns a non-empty capitalized string" do
      s = Exfake.state()
      assert is_binary(s)
      assert String.length(s) > 0
      assert s =~ ~r/^[A-Z]/
    end
  end

  describe "state_abbr/0" do
    test "returns a 2-letter uppercase abbreviation" do
      assert Exfake.state_abbr() =~ ~r/^[A-Z]{2}$/
    end
  end

  describe "country/0" do
    test "returns a non-empty string" do
      c = Exfake.country()
      assert is_binary(c)
      assert String.length(c) > 0
    end
  end

  describe "full_address/0" do
    test "matches 'street, city, ST ZIP' format" do
      assert Exfake.full_address() =~ ~r/.+, .+, [A-Z]{2} \d{5}/
    end
  end

  describe "blood_type/0" do
    test "returns one of the 8 standard blood types" do
      assert Exfake.blood_type() in ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    end
  end

  describe "hashtag/0" do
    test "starts with # followed by a lowercase word" do
      assert Exfake.hashtag() =~ ~r/^#[a-z]+$/
    end
  end

  describe "emoji/0" do
    test "returns a non-empty string" do
      e = Exfake.emoji()
      assert is_binary(e)
      assert String.length(e) > 0
    end

    test "is a single grapheme cluster" do
      assert length(String.graphemes(Exfake.emoji())) == 1
    end
  end

  describe "license_plate/0" do
    test "matches LLL-DDDD format" do
      assert Exfake.license_plate() =~ ~r/^[A-Z]{3}-\d{4}$/
    end
  end

  describe "username/0" do
    test "matches word_wordN pattern with lowercase letters, underscore, and digits" do
      assert Exfake.username() =~ ~r/^[a-z]+_[a-z]+\d+$/
    end
  end

  describe "password/0" do
    test "has the default length of 12" do
      assert String.length(Exfake.password()) == 12
    end

    test "respects a custom length" do
      assert String.length(Exfake.password(20)) == 20
    end

    test "raises for non-positive length" do
      assert_raise FunctionClauseError, fn -> Exfake.password(0) end
    end
  end

  describe "mime_type/0" do
    test "matches type/subtype format" do
      assert Exfake.mime_type() =~ ~r"^\w+/[\w.+\-]+"
    end
  end

  describe "file_name/0" do
    test "contains a name and a file extension separated by a dot" do
      assert Exfake.file_name() =~ ~r/^\w+\.\w+$/
    end
  end

  describe "user_agent/0" do
    test "returns a non-empty string" do
      ua = Exfake.user_agent()
      assert is_binary(ua)
      assert String.length(ua) > 0
    end
  end

  defp luhn_valid?(number) do
    sum =
      number
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {digit, i}, acc ->
        d = if rem(i, 2) == 1, do: digit * 2, else: digit
        acc + if d > 9, do: d - 9, else: d
      end)

    rem(sum, 10) == 0
  end
end
