
# correct
# perl downloadRepPhotos.pl E000215 out

# 404
# perl downloadRepPhotos.pl XYZ215 out

DB_PASSWD=$1
OUT_DIR=out2

perl fetchPhotos.pl $DB_PASSWD $OUT_DIR

