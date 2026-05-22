defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Humans, Phones, Lorem, Company, Xss, Internet, Web, Address}

  @doc """
  Generates first name.

  ## Examples

      iex> Exfake.first_name()
      "Jake"
      iex> Exfake.first_name()
      "Rosemary"
  """
  @spec first_name() :: String.t()
  def first_name() do
    Enum.random(Humans.first_names())
  end

  @doc """
  Generates last name.

  ## Examples

      iex> Exfake.last_name()
      "Nitzsche"
      iex> Exfake.last_name()
      "Adams"
  """
  @spec last_name() :: String.t()
  def last_name() do
    Enum.random(Humans.last_names())
  end

  @doc """
  Generates first name + last name combination.

  ## Examples

      iex> Exfake.person()
      "Jake Nitzsche"
      iex> Exfake.person()
      "Luciano Eichmann"
  """
  @spec person() :: String.t()
  def person() do
    "#{first_name()} #{last_name()}"
  end

  @doc """
  Returns a random name prefix.

  ## Examples

      iex> Exfake.name_prefix()
      "Dr."
  """
  @spec name_prefix() :: String.t()
  def name_prefix(), do: Enum.random(Humans.name_prefixes())

  @doc """
  Returns a random job title.

  ## Examples

      iex> Exfake.job_title()
      "Senior Software Engineer"
  """
  @spec job_title() :: String.t()
  def job_title(), do: Enum.random(Humans.job_titles())

  @doc """
  Generates phone number which formatted randomly.

  ## Examples

      iex> Exfake.phone_number()
      "684-126-0269"
      iex> Exfake.phone_number()
      "1-319-098-3384 x06095"
  """
  @spec phone_number() :: String.t()
  def phone_number() do
    Phones.formats()
    |> Enum.random()
    |> String.replace("#", fn _ -> Integer.to_string(Enum.random(0..9)) end)
  end

  @doc """
  Generates random english word.

  ## Examples

      iex> Exfake.word()
      "burn"
      iex> Exfake.word()
      "language"
  """
  @spec word() :: String.t()
  def word() do
    Enum.random(Lorem.en_words())
  end

  @doc """
  Generates random english sentence with specified words count.
  Words count must be greater than 1.
  Default words count is 5.

  ## Examples

      iex> Exfake.sentence()
      "Judge taste page porter harmony."
      iex> Exfake.sentence(3)
      "Event minute view."
  """
  @spec sentence(pos_integer) :: String.t()
  def sentence(count \\ 5) when count > 1 do
    beg = word() |> String.capitalize()
    body = 1..(count - 1) |> Enum.map_join(" ", fn _ -> word() end)
    "#{beg} #{body}."
  end

  @doc """
  Generates random lorem paragraph with specified sentence count and sentence words count which randoms between 2 and 5.
  Sentence count must be greater than 0.
  Default sentence count is 3.
  Default words count between 2 and 5.

  ## Examples

      iex> Exfake.paragraphs()
      "Statement waste mind. Verse sugar answer adjustment behavior. Soup attempt."
      iex> Exfake.paragraphs(3, 2)
      "Smoke ink. Cry day. Company stop."
      iex> Exfake.paragraphs(3, 2)
      "Nation wind. Sea stone. Minute comparison."
  """
  @spec paragraphs(pos_integer, pos_integer()) :: String.t()
  def paragraphs(n \\ 3, limit \\ 5) when n > 0 and limit >= 2 do
    1..n |> Enum.map_join(" ", fn _ -> sentence(Enum.random(2..limit)) end)
  end

  @doc """
  Generates a random language code.

  ## Examples

      iex> Exfake.language_code()
      "gv"
      iex> Exfake.language_code()
      "ne"
  """
  @spec language_code() :: String.t()
  def language_code() do
    Enum.random(Lorem.language_codes())
  end

  @doc """
  Generates a random company suffix.

  ## Examples

      iex> Exfake.company_suffix()
      "Inc"
      iex> Exfake.company_suffix()
      "LLC"
  """
  @spec company_suffix() :: String.t()
  def company_suffix() do
    Enum.random(Company.suffixes())
  end

  @doc """
  Generates a random company catch phrase.

  ## Examples

      iex> Exfake.catch_phrase()
      "Re-engineered maximized productivity"
      iex> Exfake.catch_phrase()
      "Right-sized hybrid complexity"
  """
  @spec catch_phrase() :: String.t()
  def catch_phrase() do
    Enum.map_join(Company.catch_phrase_words(), " ", &Enum.random/1)
  end

  @doc """
  Generates a random company BS goals.

  ## Examples

      iex> Exfake.bs()
      "reintermediate granular niches"
      iex> Exfake.bs()
      "unleash user-centric markets"
  """
  @spec bs() :: String.t()
  def bs() do
    Enum.map_join(Company.bs_words(), " ", &Enum.random/1)
  end

  @doc """
  Generates a random company name.

  ## Examples

      iex> Exfake.company_name()
      "Klein, Mueller and Windler"
      iex> Exfake.company_name()
      "Zion Kerluke LLC"
      iex> Exfake.company_name()
      "Legros-Yundt"
  """
  @spec company_name() :: String.t()
  def company_name() do
    [
      "#{person()} #{company_suffix()}",
      "#{last_name()}-#{last_name()}",
      "#{last_name()}, #{last_name()} and #{last_name()}"
    ]
    |> Enum.random()
  end

  @doc """
  Returns a random currency which represented in few format.

  ## Examples

      iex> Exfake.currency()
      ["Costa Rica Colon", "CRC", "₡"]
      iex> Exfake.currency()
      ["Japan Yen", "JPY", "¥"]
      iex> Exfake.currency()
      ["Liberia Dollar", "LRD", "$"]
  """
  @spec currency() :: [String.t(), ...]
  def currency() do
    Enum.random(Lorem.currencies())
  end

  @doc """
  Generates a random XSS string.

  ## Examples

      iex> Exfake.xss_string()
      "<BODY BACKGROUND=\"javascript:alert('XSS')\">"
      iex> Exfake.xss_string()
      "<A HREF=\"http://0102.0146.0007.00000223/\">XSS</A>"
  """
  @spec xss_string() :: String.t()
  def xss_string() do
    Enum.random(Xss.data())
  end

  @doc """
  Generates a random XSS file.

  ## Examples

      iex> Exfake.xss_file()
      "<TABLE><TD BACKGROUND=\"javascript:alert('XSS')\">.txt"
      iex> Exfake.xss_file()
      "<IMG SRC=\"javascript:alert('XSS');\">.txt"
  """
  @spec xss_file() :: String.t()
  def xss_file() do
    Enum.random(Xss.files())
  end

  @doc """
  Generates a random IPv4 address.

  ## Examples

      iex> Exfake.ipv4()
      "145.77.91.223"
      iex> Exfake.ipv4()
      "17.94.49.5"
  """
  @spec ipv4() :: String.t()
  def ipv4() do
    "#{Enum.random(1..255)}.#{Enum.random(0..255)}.#{Enum.random(0..255)}.#{Enum.random(0..255)}"
  end

  @doc """
  Generates a random IPv6 address.

  ## Examples

      iex> Exfake.ipv6()
      "BCB6:C612:24B1:D067:3B27:B8BC:187A:9CCB"
      iex> Exfake.ipv6()
      "90A1:238:65DD:EC7F:CF3A:1AB0:B2DE:C8A3"
  """
  @spec ipv6() :: String.t()
  def ipv6() do
    1..8
    |> Enum.map_join(":", fn _ -> Integer.to_string(Enum.random(0..65_535), 16) end)
  end

  @doc """
  Generates a random MAC address.

  ## Examples

      iex> Exfake.mac()
      "A1:0B:4F:C3:29:7E"
      iex> Exfake.mac()
      "00:FF:12:AB:44:C8"
  """
  @spec mac() :: String.t()
  def mac() do
    1..6
    |> Enum.map_join(":", fn _ ->
      Enum.random(0..255)
      |> Integer.to_string(16)
      |> String.pad_leading(2, "0")
    end)
  end

  @doc """
  Generates a random HTTP code.

  ## Examples

      iex> Exfake.http_code()
      308
      iex> Exfake.http_code()
      201
      iex> Exfake.http_code(:info)
      102
      iex> Exfake.http_code(:server_error)
      503
  """
  @spec http_code() :: non_neg_integer()
  @spec http_code(:client_error | :info | :redirection | :server_error | :success) ::
          non_neg_integer()
  def http_code() do
    [:info, :success, :redirection, :client_error, :server_error]
    |> Enum.random()
    |> http_code()
  end

  def http_code(code)
      when code in [:info, :success, :redirection, :client_error, :server_error] do
    Map.get(Internet.status_codes(), code) |> Enum.random()
  end

  @doc """
  Generates a random email.

  ## Examples

      iex> Exfake.email()
      "dallas@gmail.com"
      iex> Exfake.email()
      "miller@hotmail.com"
  """
  @spec email() :: String.t()
  def email() do
    "#{String.downcase(first_name())}@#{Enum.random(Internet.free_domains())}"
  end

  @doc """
  Generates a random domain.

  ## Examples

      iex> Exfake.domain()
      "www.laboriosam.me"
      iex> Exfake.domain()
      "www.nihil.biz"
  """
  @spec domain() :: String.t()
  def domain() do
    "www.#{String.downcase(word())}.#{Enum.random(Internet.suffixes())}"
  end

  @doc """
  Generates a random URL.

  ## Examples

      iex> Exfake.url()
      "http://www.roll.me"
      iex> Exfake.url()
      "https://www.front.com"
  """
  @spec url() :: String.t()
  def url() do
    protocol = Enum.random(["http", "https"])
    "#{protocol}://#{domain()}"
  end

  @doc """
  Generates a random USA zip code.

  ## Examples

      iex> Exfake.zip_code()
      "32107-6766"
      iex> Exfake.zip_code()
      "91527"
  """
  @spec zip_code() :: String.t()
  def zip_code() do
    without_dash = 1..5 |> Enum.map_join(fn _ -> Enum.random(0..9) end)
    with_dash = "#{without_dash}-#{Enum.map_join(1..4, fn _ -> Enum.random(0..9) end)}"

    [with_dash, without_dash] |> Enum.random()
  end

  @doc """
  Generates a random boolean.

  ## Examples

      iex> Exfake.boolean()
      true
  """
  @spec boolean() :: boolean()
  def boolean(), do: Enum.random([true, false])

  @doc """
  Generates a random integer between min and max (inclusive).

  ## Examples

      iex> Exfake.integer(1, 10)
      7
  """
  @spec integer(integer(), integer()) :: integer()
  def integer(min, max) when is_integer(min) and is_integer(max) and min <= max do
    Enum.random(min..max)
  end

  @doc """
  Generates a random float between min and max.

  ## Examples

      iex> Exfake.float(1.0, 5.0)
      3.14
  """
  @spec float(number(), number()) :: float()
  def float(min, max) when is_number(min) and is_number(max) and min <= max do
    min + :rand.uniform() * (max - min)
  end

  @doc """
  Generates a random UUID v4.

  ## Examples

      iex> Exfake.uuid()
      "f47ac10b-58cc-4372-a567-0e02b2c3d479"
  """
  @spec uuid() :: String.t()
  def uuid() do
    <<a::32, b::16, _::4, c::12, _::2, d::6, e::8, f::48>> = :crypto.strong_rand_bytes(16)
    time_hi = 0x4000 + c
    clk_seq = (0x80 + d) * 256 + e

    "#{pad_hex(a, 8)}-#{pad_hex(b, 4)}-#{pad_hex(time_hi, 4)}-#{pad_hex(clk_seq, 4)}-#{pad_hex(f, 12)}"
  end

  @doc """
  Generates a random hex color code.

  ## Examples

      iex> Exfake.hex_color()
      "#A3F2C1"
  """
  @spec hex_color() :: String.t()
  def hex_color() do
    "#" <>
      hex_byte(Enum.random(0..255)) <>
      hex_byte(Enum.random(0..255)) <>
      hex_byte(Enum.random(0..255))
  end

  @doc """
  Returns a random RGB color as a `{red, green, blue}` tuple.

  ## Examples

      iex> Exfake.rgb_color()
      {163, 242, 193}
  """
  @spec rgb_color() :: {0..255, 0..255, 0..255}
  def rgb_color() do
    {Enum.random(0..255), Enum.random(0..255), Enum.random(0..255)}
  end

  @doc """
  Generates a random URL slug.

  ## Examples

      iex> Exfake.slug()
      "mountain-river-42"
  """
  @spec slug() :: String.t()
  def slug() do
    "#{word()}-#{word()}-#{Enum.random(1..999)}"
  end

  @doc """
  Generates a random semantic version string.

  ## Examples

      iex> Exfake.semver()
      "2.14.3"
  """
  @spec semver() :: String.t()
  def semver() do
    "#{Enum.random(0..10)}.#{Enum.random(0..20)}.#{Enum.random(0..99)}"
  end

  @doc """
  Returns a random TCP/UDP port number (1–65535).

  ## Examples

      iex> Exfake.port()
      8080
  """
  @spec port() :: 1..65_535
  def port(), do: Enum.random(1..65_535)

  @doc """
  Generates a random `Date` within ±10 years of today.

  ## Examples

      iex> Exfake.date()
      ~D[2023-07-14]
  """
  @spec date() :: Date.t()
  def date() do
    Date.add(Date.utc_today(), Enum.random(-3650..3650))
  end

  @doc """
  Generates a random `Date` in the past, within the given number of days.

  ## Examples

      iex> Exfake.past_date()
      ~D[2025-11-03]
      iex> Exfake.past_date(30)
      ~D[2026-04-28]
  """
  @spec past_date(pos_integer()) :: Date.t()
  def past_date(days \\ 365) when is_integer(days) and days > 0 do
    Date.add(Date.utc_today(), -Enum.random(1..days))
  end

  @doc """
  Generates a random `Date` in the future, within the given number of days.

  ## Examples

      iex> Exfake.future_date()
      ~D[2026-09-17]
      iex> Exfake.future_date(30)
      ~D[2026-06-10]
  """
  @spec future_date(pos_integer()) :: Date.t()
  def future_date(days \\ 365) when is_integer(days) and days > 0 do
    Date.add(Date.utc_today(), Enum.random(1..days))
  end

  @doc """
  Generates a random `Time`.

  ## Examples

      iex> Exfake.time()
      ~T[14:32:07]
  """
  @spec time() :: Time.t()
  def time() do
    Time.new!(Enum.random(0..23), Enum.random(0..59), Enum.random(0..59))
  end

  @doc """
  Generates a random UTC `DateTime`.

  ## Examples

      iex> Exfake.datetime()
      #DateTime<2023-07-14 14:32:07Z>
  """
  @spec datetime() :: DateTime.t()
  def datetime() do
    DateTime.new!(date(), time(), "Etc/UTC")
  end

  @doc """
  Returns a random IANA timezone name.

  ## Examples

      iex> Exfake.timezone()
      "America/New_York"
  """
  @spec timezone() :: String.t()
  def timezone(), do: Enum.random(Lorem.timezones())

  @doc """
  Generates a random price rounded to 2 decimal places.

  ## Examples

      iex> Exfake.price()
      249.99
      iex> Exfake.price(5.0, 20.0)
      14.37
  """
  @spec price(number(), number()) :: float()
  def price(min \\ 1.0, max \\ 1000.0) when is_number(min) and is_number(max) and min <= max do
    (min + :rand.uniform() * (max - min)) |> Float.round(2)
  end

  @doc """
  Returns a random credit card type name.

  ## Examples

      iex> Exfake.credit_card_type()
      "Visa"
  """
  @spec credit_card_type() :: String.t()
  def credit_card_type() do
    Enum.random(["Visa", "Mastercard", "American Express", "Discover", "JCB"])
  end

  @doc """
  Generates a random Luhn-valid credit card number (15–16 digits).

  ## Examples

      iex> Exfake.credit_card_number()
      "4532015112830366"
  """
  @spec credit_card_number() :: String.t()
  def credit_card_number() do
    {prefix, length} = Enum.random(Lorem.card_prefixes())
    fill = length - String.length(prefix) - 1
    partial = prefix <> Enum.map_join(1..fill, fn _ -> Integer.to_string(Enum.random(0..9)) end)
    partial <> Integer.to_string(luhn_check_digit(partial))
  end

  @doc """
  Generates a random US Social Security Number in XXX-XX-XXXX format.

  ## Examples

      iex> Exfake.ssn()
      "078-05-1120"
  """
  @spec ssn() :: String.t()
  def ssn() do
    area = Enum.random(1..899) |> Integer.to_string() |> String.pad_leading(3, "0")
    group = Enum.random(1..99) |> Integer.to_string() |> String.pad_leading(2, "0")
    serial = Enum.random(1..9999) |> Integer.to_string() |> String.pad_leading(4, "0")
    "#{area}-#{group}-#{serial}"
  end

  @doc """
  Generates a random US Employer Identification Number in XX-XXXXXXX format.

  ## Examples

      iex> Exfake.tax_id()
      "12-3456789"
  """
  @spec tax_id() :: String.t()
  def tax_id() do
    prefix = Enum.random(10..99)
    suffix = Enum.random(1_000_000..9_999_999)
    "#{prefix}-#{suffix}"
  end

  @doc """
  Returns a random MIME type string.

  ## Examples

      iex> Exfake.mime_type()
      "image/png"
  """
  @spec mime_type() :: String.t()
  def mime_type() do
    {mime, _ext} = Enum.random(Web.mime_types())
    mime
  end

  @doc """
  Generates a random file name with an extension matching a random MIME type.

  ## Examples

      iex> Exfake.file_name()
      "river.pdf"
  """
  @spec file_name() :: String.t()
  def file_name() do
    {_mime, ext} = Enum.random(Web.mime_types())
    "#{word()}.#{ext}"
  end

  @doc """
  Returns a random browser User-Agent string.

  ## Examples

      iex> Exfake.user_agent()
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ..."
  """
  @spec user_agent() :: String.t()
  def user_agent() do
    Enum.random(Web.user_agents())
  end

  @doc """
  Generates a random username in the form `word_wordN`.

  ## Examples

      iex> Exfake.username()
      "mountain_river42"
  """
  @spec username() :: String.t()
  def username() do
    "#{word()}_#{word()}#{Enum.random(1..99)}"
  end

  @doc """
  Returns a random US city name.

  ## Examples

      iex> Exfake.city()
      "Denver"
  """
  @spec city() :: String.t()
  def city(), do: Enum.random(Address.cities())

  @doc """
  Generates a random US street address.

  ## Examples

      iex> Exfake.street_address()
      "742 Elm Street"
  """
  @spec street_address() :: String.t()
  def street_address() do
    "#{Enum.random(1..9999)} #{Enum.random(Address.street_names())} #{Enum.random(Address.street_types())}"
  end

  @doc """
  Returns a random US state name.

  ## Examples

      iex> Exfake.state()
      "California"
  """
  @spec state() :: String.t()
  def state() do
    {name, _abbr} = Enum.random(Address.states())
    name
  end

  @doc """
  Returns a random US state abbreviation.

  ## Examples

      iex> Exfake.state_abbr()
      "CA"
  """
  @spec state_abbr() :: String.t()
  def state_abbr() do
    {_name, abbr} = Enum.random(Address.states())
    abbr
  end

  @doc """
  Returns a random country name.

  ## Examples

      iex> Exfake.country()
      "Germany"
  """
  @spec country() :: String.t()
  def country(), do: Enum.random(Address.countries())

  @doc """
  Generates a full US address combining street, city, state, and ZIP.

  ## Examples

      iex> Exfake.full_address()
      "742 Elm Street, Denver, CO 80201"
  """
  @spec full_address() :: String.t()
  def full_address() do
    "#{street_address()}, #{city()}, #{state_abbr()} #{zip_code()}"
  end

  @doc """
  Returns a random ABO/Rh blood type.

  ## Examples

      iex> Exfake.blood_type()
      "O+"
  """
  @spec blood_type() :: String.t()
  def blood_type(), do: Enum.random(Humans.blood_types())

  @doc """
  Generates a random hashtag built from an English word.

  ## Examples

      iex> Exfake.hashtag()
      "#language"
  """
  @spec hashtag() :: String.t()
  def hashtag(), do: "##{word()}"

  @doc """
  Returns a random emoji.

  ## Examples

      iex> Exfake.emoji()
      "🚀"
  """
  @spec emoji() :: String.t()
  def emoji(), do: Enum.random(Lorem.emojis())

  @doc """
  Generates a random license plate in LLL-DDDD format.

  ## Examples

      iex> Exfake.license_plate()
      "ABC-1234"
  """
  @spec license_plate() :: String.t()
  def license_plate() do
    letters = Enum.map_join(1..3, fn _ -> Enum.random(Lorem.uppercase_letters()) end)
    digits = Enum.map_join(1..4, fn _ -> Integer.to_string(Enum.random(0..9)) end)
    "#{letters}-#{digits}"
  end

  @doc """
  Generates a random password of the given length (default 12).

  ## Examples

      iex> Exfake.password()
      "aB3!xZ9@kL2#"
      iex> Exfake.password(20)
      "Xk3!mZ9@aB2#qR5&wT1%"
  """
  @spec password(pos_integer()) :: String.t()
  def password(length \\ 12) when is_integer(length) and length > 0 do
    1..length |> Enum.map_join(fn _ -> Enum.random(Web.password_chars()) end)
  end

  defp luhn_check_digit(partial) do
    sum =
      partial
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {digit, i}, acc ->
        d = if rem(i, 2) == 0, do: digit * 2, else: digit
        acc + if d > 9, do: d - 9, else: d
      end)

    rem(10 - rem(sum, 10), 10)
  end

  defp pad_hex(n, len) do
    n |> Integer.to_string(16) |> String.downcase() |> String.pad_leading(len, "0")
  end

  defp hex_byte(n) do
    n |> Integer.to_string(16) |> String.upcase() |> String.pad_leading(2, "0")
  end
end
