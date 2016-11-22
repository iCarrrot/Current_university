aut1 = (["a", "b"], 0, \_ c -> if c == "a" then 0 else 1, \i-> i == 1 )
 

--To chyba spełnia założenia zadania, oprócz tego, że tworzy dodatkową krotkę ze stanem, który geberuje dany wyraz
generate3 (alph,stan,f,check) =  
    ([],check(stan ),stan):[ ((w++c),check(f stan1 (c)), f stan1 (c) ) | (w,checked,stan1) <- (generate3 (alph,stan,f,check)), c <- alph]
 
--mój brak sensownego pomysłu na usunięcie stanu z krotki:

aut_words automat = [(w,c)|(w,c,_)<-generate3(automat)]

accepted_words automat=[w |(w,c)<-(aut_words automat),c==True]