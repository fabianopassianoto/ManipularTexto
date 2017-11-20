Boa tarde a todos.

Alguns me ouviram comentar que tenho uma certa aversão a utilizar StringList, porém poucos conhecem as alternativas a ele.
Os motivos são de que ela é lenta, pesada, possuia vazamentos de memória na sua própria implementação.
Além de consumir alto recurso de memória, cada linha se torna um objeto interno, e na maioria das vezes é utilizada para soluções simples (análisar o custo benefício)
Por ser um recurso altamente utilizado na TecnoSpeed, resolvi apresentar algumas alternativas na prática e compartilhar com todos, para isso criei um pequeno projeto no GitHub https://github.com/fabianopassianoto/ManipularTexto.git , 
agradeço também a quem quiser colaborar é GitHub :wink: então existem Mil maneiras de se manipular arquivo texto, "invente a sua" rsrs, junto com este pequeno BenchMark do resultado das alternativas que levantei: MemoryStream, TextFile, FileStream, StringStream, StreamReader.
O BenchMark é o resultado da leitura de um arquivo total e de alguns exemplos linha a linha, de 1 milhão de linhas, e 30mgb de tamanho.

MemoryStream  p/ LER 0,380481778083408 s.
 MemoryStream p/ PERCORRER 8,57147170340644 s.
 TextFile demorou p/ PERCORRER 0,855768498822668 s.
 FileStream demorou p/ LER 0,049781083829626 s.
 FileStream demorou p/ PERCORRER 173,807860540264 s.
 StringList p/ LER 0,248418748701 s.
 StringStream demorou p/ LER 13,2821328653086 s.
 StringStream demorou p/ PERCORRER 2,83561828957148 s.
 StreamReader demorou p/ LER 0,259323930073411 s.
 StreamReader demorou p/ PERCORRER 1,00315523247708 s.

Em defesa de alguns como FileStream ser extremamente mais lento linha a linha e muito mais rápido em sua leitura geral, é porque sua montagem de linha é Byte a Byte, o que pode ser um pouco mais custoso, por isso é interessante,
escolher a melhor solução para a sua necessidade, a implementação do BenchMark e como ler estes arquivos está no fonte citado no GitHub, espero poder ter ajudado.