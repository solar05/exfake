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
    {:exfake, "~> 2.2.0"}
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

# Finance
Exfake.currency()
["Japan Yen", "JPY", "¥"]

Exfake.zip_code()
"32107-6766"

# Security testing
Exfake.xss_string()
"<BODY BACKGROUND=\"javascript:alert('XSS')\">"

Exfake.xss_file()
"<IMG SRC=\"javascript:alert('XSS');\">.txt"
```
