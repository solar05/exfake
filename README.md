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
    {:exfake, "~> 1.0.0"}
  ]
end
```

Documentation can be found at [HexDocs.](https://hexdocs.pm/exfake/Exfake.html)

## Usage examples

```elixir
Exfake.gen_zip_code()
"32107-6766"

Exfake.gen_first_name()
"Rosemary"

Exfake.gen_person()
"Luciano Eichmann"

Exfake.gen_phone_number()
"684-126-0269"

Exfake.gen_sentence()
"Event minute view."

Exfake.gen_paragraphs()
"Statement waste mind. Verse sugar answer adjustment behavior. Soup attempt."

Exfake.gen_catch_phrase()
"Re-engineered maximized productivity"

Exfake.gen_company_name()
"Klein, Mueller and Windler"

Exfake.gen_ipv4()
"145.77.91.223"

Exfake.gen_domain()
"www.laboriosam.me"
```

Other generators are described in [hex documentation.](https://hexdocs.pm/exfake/Exfake.html)
