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
    {:exfake, "~> 2.1.0"}
  ]
end
```

Documentation can be found at [HexDocs.](https://hexdocs.pm/exfake/Exfake.html)

## Usage examples

```elixir
Exfake.zip_code()
"32107-6766"

Exfake.first_name()
"Rosemary"

Exfake.person()
"Luciano Eichmann"

Exfake.phone_number()
"684-126-0269"

Exfake.sentence()
"Event minute view."

Exfake.paragraphs()
"Statement waste mind. Verse sugar answer adjustment behavior. Soup attempt."

Exfake.catch_phrase()
"Re-engineered maximized productivity"

Exfake.company_name()
"Klein, Mueller and Windler"

Exfake.ipv4()
"145.77.91.223"

Exfake.ipv6()
"BCB6:C612:24B1:D067:3B27:B8BC:187A:9CCB"

Exfake.domain()
"www.laboriosam.me"

Exfake.currency()
["Japan Yen", "JPY", "¥"]

Exfake.language_code()
"ne"
```

Other generators are described in [hex documentation.](https://hexdocs.pm/exfake/Exfake.html)
