require "./best_commiter/*"

cli = BestCommiter::CLI.new
cli.try_run(ARGV)
