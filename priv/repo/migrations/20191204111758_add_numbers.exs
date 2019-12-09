defmodule LottoMachine.Repo.Migrations.AddNumbers do
  use Ecto.Migration

  def change do
    create table("lotto_numbers") do
      add :numbers, {:array, :integer}
      add :type, :string, size: 50
      add :user_hash, :string

      timestamps()
    end
  end
end
