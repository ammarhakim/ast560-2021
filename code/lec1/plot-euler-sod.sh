pgkyl euler-sodshock-exact_density.bp -l "Exact" euler-sodshock_fluid_1.bp -t FV -l "FV" sel -u "FV" -c0 pl -f0 -x "X" -y '$\rho$' &
pgkyl euler-sodshock-exact_density.bp -l "Exact" euler-sodshock-no-limiter_fluid_1.bp -t "BAD" -l "BAD" sel -u "BAD" -c0 pl -f0 -x "X" -y '$\rho$'
