[![CI](https://github.com/solar05/exfake/actions/workflows/elixir.yml/badge.svg)](https://github.com/solar05/exfake/actions/workflows/elixir.yml)
![Hex.pm](https://img.shields.io/hexpm/v/exfake)
![Hex.pm](https://img.shields.io/hexpm/l/exfake)
# Exfake

Elixir library for fake data generation.

## Installation

The package [available in Hex](https://hex.pm/packages/exfake) and can be installed
by adding `exfake` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exfake, "~> 2.3.0"}
  ]
end
```

Documentation can be found at [HexDocs.](https://hexdocs.pm/exfake/Exfake.html)

## Usage examples

```elixir
# Names
Exfake.first_name()
"Rosemary"

Exfake.last_name()
"Nitzsche"

Exfake.person()
"Luciano Eichmann"

# Phone
Exfake.phone_number()
"684-126-0269"

# Text
Exfake.word()
"language"

Exfake.sentence()
"Event minute view."

Exfake.paragraphs()
"Statement waste mind. Verse sugar answer adjustment behavior. Soup attempt."

Exfake.language_code()
"ne"

# Company
Exfake.company_suffix()
"LLC"

Exfake.catch_phrase()
"Re-engineered maximized productivity"

Exfake.bs()
"unleash user-centric markets"

Exfake.company_name()
"Klein, Mueller and Windler"

# Internet
Exfake.email()
"dallas@gmail.com"

Exfake.domain()
"www.laboriosam.me"

Exfake.url()
"https://www.front.com"

Exfake.ipv4()
"145.77.91.223"

Exfake.ipv6()
"BCB6:C612:24B1:D067:3B27:B8BC:187A:9CCB"

Exfake.mac()
"A1:0B:4F:C3:29:7E"

Exfake.http_code()
201

Exfake.http_code(:server_error)
503

Exfake.mime_type()
"image/png"

Exfake.file_name()
"river.pdf"

Exfake.user_agent()
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ..."

Exfake.uuid()
"f47ac10b-58cc-4372-a567-0e02b2c3d479"

Exfake.hex_color()
"#A3F2C1"

# Address
Exfake.city()
"Denver"

Exfake.street_address()
"742 Elm Street"

Exfake.state()
"California"

Exfake.state_abbr()
"CA"

Exfake.country()
"Germany"

Exfake.full_address()
"742 Elm Street, Denver, CO 80201"

# Finance
Exfake.currency()
["Japan Yen", "JPY", "¥"]

Exfake.zip_code()
"32107-6766"

Exfake.price()
249.99

Exfake.price(5.0, 20.0)
14.37

Exfake.credit_card_type()
"Visa"

Exfake.credit_card_number()
"4532015112830366"

# Identity
Exfake.username()
"mountain_river42"

Exfake.password()
"aB3!xZ9@kL2#"

Exfake.password(20)
"Xk3!mZ9@aB2#qR5&wT1%"

# Primitives
Exfake.boolean()
true

Exfake.integer(1, 100)
42

Exfake.float(1.0, 5.0)
3.14

# Date
Exfake.date()
~D[2023-07-14]

Exfake.past_date()
~D[2025-11-03]

Exfake.future_date()
~D[2026-09-17]

# Security testing
Exfake.xss_string()
"<BODY BACKGROUND=\"javascript:alert('XSS')\">"

Exfake.xss_file()
"<IMG SRC=\"javascript:alert('XSS');\">.txt"
```
