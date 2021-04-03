# grep-available
# Autogenerated from man page /usr/share/man/man1/grep-available.1.gz
complete -c grep-available -l pattern --description 'Specify a  pattern to be searched.'
complete -c grep-available -s F -l field --description 'Restrict pattern matching to the  R field s given.'
complete -c grep-available -s P --description 'Shorthand for  -FPackage .'
complete -c grep-available -s S --description 'Shorthand for  -FSource:Package .'
complete -c grep-available -s e -l eregex --description 'Regard the pattern of the current simple filter as an extended POSIX regular …'
complete -c grep-available -s r -l regex --description 'Regard the pattern of the current simple filter as a standard POSIX regular e…'
complete -c grep-available -s i -l ignore-case --description 'Ignore case when looking for a match in the current simple filter.'
complete -c grep-available -s X -l exact-match --description 'Do an exact match (as opposed to a substring match) in the current simple fil…'
complete -c grep-available -s w -l whole-pkg --description 'Do an extended regular expression match on whole package names, assuming the …'
complete -c grep-available -l eq --description 'Do an equality comparison under the Debian version number system.'
complete -c grep-available -l lt --description 'Do an strictly-less-than comparison under the Debian version number system.'
complete -c grep-available -l le --description 'Do an less-than-or-equal comparison under the Debian version number system.'
complete -c grep-available -l gt --description 'Do an strictly-greater-than comparison under the Debian version number system.'
complete -c grep-available -l ge --description 'Do an greater-than-or-equal comparison under the Debian version number system.'
complete -c grep-available -l not --description 'Match if the following filter does   not match.'
complete -c grep-available -s o -l or --description 'Match if either one or both of the preceding and following filters matches.'
complete -c grep-available -s a -l and --description 'Match if both the preceding and the following filter match.'
complete -c grep-available -s l -l files-with-matches --description 'Output only the file names, each on its own line, of those files that contain…'
complete -c grep-available -s L -l files-without-matches --description 'Output only the file names, each on its own line, of those files that do not …'
complete -c grep-available -s s -l show-field --description 'Show only the body of these R field s from the matching paragraphs.'
complete -c grep-available -s I -l invert-show --description 'Invert the meaning of option  -s : show only the fields that have  not been n…'
complete -c grep-available -s d --description 'Show only the first line of the  Description field from the matching paragrap…'
complete -c grep-available -s n -l no-field-names --description 'Suppress field names when showing specified fields, only their bodies are sho…'
complete -c grep-available -s v -l invert-match --description 'Instead of showing all the paragraphs that match, show those paragraphs that …'
complete -c grep-available -s c -l count --description 'Instead of showing the paragraphs that match (or, with   -v , that don\'t matc…'
complete -c grep-available -s q -l quiet -l silent --description 'Output nothing to the standard output stream.'
complete -c grep-available -l ensure-dctrl --description 'Ensure that the output is in dctrl format, specifically that there always is …'
complete -c grep-available -l compat --description 'Override any  --ensure-dctrl option given earlier on the command line.'
complete -c grep-available -l ignore-parse-errors --description 'Ignore errors in parsing input.'
complete -c grep-available -l debug-optparse --description 'Show how the current command line has been parsed.'
complete -c grep-available -l errorlevel --description 'Set log level to R level .'
complete -c grep-available -s V -l version --description 'Print out version information.'
complete -c grep-available -s C -l copying --description 'Print out the copyright license.'
complete -c grep-available -o FPackage --description '.'
complete -c grep-available -o FSource:Package --description '.'
complete -c grep-available -l ensure--dctrl --description 'option, if only one field is selected, no paragraph separator is output.'
complete -c grep-available -s h -l help --description 'Print out a help summary.'

