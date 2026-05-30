#!/usr/bin/env bash
# Download verified Wikimedia Commons images into docs/assets/<landmark>/.
# Uses Special:FilePath (follows redirect to upload.wikimedia.org). Width-limited
# to keep file sizes reasonable. Re-runnable: skips files already downloaded.
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ASSETS="$ROOT/docs/assets"
UA="ICRA26-Austria-Guide/1.0 (https://github.com/; educational travel guide) curl"

urlencode() { python3 -c "import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1].replace(' ','_')))" "$1"; }

# args: <commons filename> <local relative path under assets> <width>
get() {
  local name="$1" out="$2" width="${3:-1280}"
  local dest="$ASSETS/$out"
  mkdir -p "$(dirname "$dest")"
  if [[ -s "$dest" ]]; then echo "skip  $out"; return 0; fi
  local enc; enc="$(urlencode "$name")"
  local url="https://commons.wikimedia.org/wiki/Special:FilePath/${enc}?width=${width}"
  for attempt in 1 2 3 4; do
    if curl -fSL --retry 2 --retry-delay 3 -A "$UA" "$url" -o "$dest" 2>/dev/null && [[ -s "$dest" ]]; then
      echo "ok    $out  ($(du -h "$dest" | cut -f1))"
      return 0
    fi
    echo "retry $out (attempt $attempt)"; sleep 8
  done
  echo "FAIL  $out  <- $name"
  rm -f "$dest"
  return 1
}

# ---- Intro portraits ----
get "Kaiserin Maria Theresia (HRR).jpg"                              intro/maria-theresa.jpg 800
get "Anton von Maron - Portrait of Emperor Joseph II - WGA14128.jpg" intro/joseph-ii.jpg 800
get "Jacob van Schuppen - Prinz Eugen von Savoyen.jpeg"             intro/eugene.jpg 800
get "Archduke Charles of Austria (J.B. Seele, 1800).jpg"           intro/charles.jpg 800
get "Karl von Schwarzenberg.jpg"                                    intro/schwarzenberg.jpg 800
get "Radetzky-von-radetz.jpg"                                       intro/radetzky.jpg 800
get "Sigmund Freud, by Max Halberstadt (cropped).jpg"              intro/freud.jpg 800
get "Ignaz Semmelweis 1860.jpg"                                     intro/semmelweis.jpg 800
get "Klimt.jpg"                                                     intro/klimt.jpg 800

# ---- Belvedere ----
get "Gustav Klimt 016.jpg"                                          belvedere/klimt-kiss.jpg 1100
get "Wien - Schloss Belvedere, oberes (1).JPG"                     belvedere/upper-belvedere.jpg
get "Palacio Belvedere, Viena, Austria, 2020-02-01, DD 93-95 HDR.jpg" belvedere/upper-belvedere-hdr.jpg
get "Belvedere museum, Vienna.JPG"                                  belvedere/belvedere-museum.jpg

# ---- Schönbrunn ----
get "Wien - Schlossanlage Schönbrunn.JPG"                          schonbrunn/complex.jpg
get "Gloriette, Schlosspark Schönbrunn, Wien.jpg"                  schonbrunn/gloriette.jpg
get "Schloss Schoenbrunn Gloriette DSC02028.JPG"                   schonbrunn/gloriette2.jpg
get "A view of the Schloss Schönbrunn Wien.JPG"                    schonbrunn/gardens.jpg

# ---- Hofburg & Heldenplatz ----
get "Wien - Heldenplatz, Prinz-Eugen-Denkmal (2).JPG"             hofburg/eugene-statue.jpg
get "Wien - Heldenplatz, Prinz-Eugen-Denkmal (3).JPG"             hofburg/eugene-statue2.jpg
get "Wien - Neue Hofburg.JPG"                                      hofburg/neue-hofburg.jpg
get "Erzherzog Karl Heldenplatz.JPG"                               hofburg/charles-statue.jpg

# ---- Stephansdom ----
get "Stephansdom Dach Adler.JPG"                                   stephansdom/roof-eagle.jpg
get "Tiles view, Vienna Cathedral.jpg"                             stephansdom/roof-tiles.jpg
get "Wappen der Republik Österreich am Albertinischen Chordach des Stephansdoms in Wien.jpg" stephansdom/roof-coat-austria.jpg
get "Wien - Stephansdom, Dach, nordseitige Wappen.JPG"            stephansdom/roof-north.jpg
get "Wien - Riesentor 1.jpg"                                       stephansdom/riesentor.jpg
get "Stephansdom Riesentor Fries 01.JPG"                           stephansdom/riesentor-frieze.jpg
get "Wien Stephansdom Pummerin.jpg"                                stephansdom/pummerin.jpg
get "Wien Stephansdom Pummerin Detail.jpg"                         stephansdom/pummerin-detail.jpg

# ---- Peterskirche ----
get "Peterskirche, Vienna, facade.jpg"                             peterskirche/facade.jpg
get "Sint-Petruskerk (Wenen) koepel 5-06-2023 11-44-49.jpg"       peterskirche/dome-exterior.jpg
get "Sint-Petruskerk (Wenen) kerkschip en koor 5-06-2023 11-37-57.jpg" peterskirche/nave.jpg
get "Sint-Petruskerk (Wenen) hoogaltaar 5-06-2023 11-39-51.jpg"   peterskirche/high-altar.jpg
get "Wien - Peterskirche 1701-22 - View Up into the oval Dome (1st in Baroque Vienna) - Frescos 1713 by Johann Michael Rottmayr I.jpg" peterskirche/dome-fresco.jpg
get "Wien St. Peter Innen Kuppel 1.JPG"                            peterskirche/cupola.jpg

# ---- Karlskirche ----
get "Karlskirche Vienna Front.jpg"                                 karlskirche/front.jpg
get "Karlskirche, Vienna - Triumph columns.jpg"                    karlskirche/columns.jpg
get "Karlskirche column detail - Vienna.jpg"                       karlskirche/column-detail.jpg
get "Wien - Karlskirche, Innenansicht (a).JPG"                     karlskirche/dome-interior.jpg
get '2019 - Wiener Karlskirche mit Teich und "Hill Arches" Skulptur am Abend.jpg' karlskirche/pool-moore.jpg

# ---- Soviet War Memorial & Hochstrahlbrunnen ----
get "Wien - Heldendenkmal der Roten Armee.JPG"                    soviet/memorial.jpg
get "Wien - Schwarzenbergplatz - Heroes' Monument for the Red Army 01.jpg" soviet/memorial-overview.jpg
get "Russendenkmal am Schwarzenbergplatz Soldatenstandbild.jpg"   soviet/soldier.jpg
get "Heldendenkmal back side, Hochstrahlbrunnen.jpg"              soviet/fountain-memorial.jpg
get "Fountain near the Soviet War Memorial (7997104114).jpg"      soviet/fountain.jpg

echo "=== DONE ==="