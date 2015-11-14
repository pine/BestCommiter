require "./best_commiter/*"

cli = BestCommiter::CLI.new
cli.run(ARGV)
