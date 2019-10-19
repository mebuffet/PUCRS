import sys

import get_
import set_
import next_
import walk_
import getbulk_
import gettable_
import getdelta_

from optparse     import OptionParser

def ParseOption():
    err = False
    parser = OptionParser()

    parser.add_option("-p", "--public"   , dest="public"   , help='publico'   , action='store_true', default='false')
    parser.add_option("-c", "--community", dest="community", help='comunidade')
    parser.add_option("-t", "--target"   , dest="target"   , help='alvo'      )

    parser.add_option("--get"     , dest="get"     , help='metodo get' )
    parser.add_option("--next"    , dest="next"    , help='metodo next')

    parser.add_option("--set"     , dest="set"     , help='ID do objeto')
    parser.add_option("--vset"    , dest="vset"    , help='valor do set')

    parser.add_option("--getbulk" , dest="getbulk" , help='ID od objeto')
    parser.add_option("--NR"      , dest="NR"      , help='valor de NR' )
    parser.add_option("--NC"      , dest="NC"      , help='valor de NC' )

    parser.add_option("--walk"    , dest="walk"    , help='metodo walk'    )
    parser.add_option("--gettable", dest="gettable", help='metodo gettable')

    parser.add_option("--getdelta", dest="getdelta", help='metodo getdelta'                            )
    parser.add_option("--NA"      , dest="NA"      , help='Numero de amostras', type='int', default='0')
    parser.add_option("--NT"      , dest="NT"      , help='Intervalo de tempo', type='int', default='0')

    options, args = parser.parse_args()

    if (options.community == None) and (options.target == None):
        err = True
        parser.error('Parametros community e target sao obriatorios')

    if not err:
        return options
    else:
        return None

if __name__ == '__main__':
        options = ParseOption()

        if (options == None):
            exit()

        if   not (options.get      == None): get_.Get(options)
        elif not (options.next     == None): next_.Next(options)
        elif not (options.set      == None): set_.Set(options)
        elif not (options.getbulk  == None): getbulk_.Getbulk(options)
        elif not (options.walk     == None): walk_.Walk(options)
        elif not (options.gettable == None): gettable_.Gettable(options)
        elif not (options.getdelta == None): getdelta_.Getdelta(options)
