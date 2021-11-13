# Script for populating the database. You can run it as=>
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly=>
#
#     Faulkner.Repo.insert!(%Faulkner.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Faulkner.Repo
alias Faulkner.Writing
alias Faulkner.Writing.Assignment

Repo.delete_all(Assignment)
Writing.create_assignment(%{
  "title" => "The Complete Guide To Elixir Secrets",
  "description" => "Elixir leverages the Erlang VM, known for running low-latency, distributed, and fault-tolerant systems.",
  "status" => :planned,
  "deadline" => %{"day" => "31", "month" => "12", "year" => "2021"},
  "started_at" => %{"day" => "15", "month" => "1", "year" => "2022"},
  "tags" => [
    "elixir",
    "functional-programming"
  ],
})
