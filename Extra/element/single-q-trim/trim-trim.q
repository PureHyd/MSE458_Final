ntail=$(sed -n '/ATOMIC_SPECIES/=' $a)
ntot=$(wc -l < $a)
ntrim=$(($ntot-$ntail+1))
tail -$ntrim $a > ../single-q-trim/${b}-trim.q
done

