# Data used for trip-based model estimation
Three datasets are frankensteined together for this. Unfortunately, all three had some pre-processing applied outside this application, and are not being pulled from any canonical location. TODO: Pull this data from whatever data store is canonical.

## Travel survey
First is the PSRC travel survey person-trips data table. Original data source is:
R:\CHRIS\Development\HHSurvey2006\HHSurveyFinal.mdb

Variables include:
persontrip.id, zone.id.from, zone.id.to, mode.id, choice, hhnumveh, hhnumwkr, totalinc

## Zonal data
Variables include:

origin.district.id
destination.district.id
intperkm.origin
intperkm.destination
mixed.use.origin
mixed.use.destination	walkability.origin
walkability.destination
retail.ratio.origin
retail.ratio.destination

## Model skims from Emme/2
These cryptically named variables will also be included. Though for a
data dictionary, one should look... elsewhere. The short form of the
variable is the emmebank's internal name, while the long form is the
description. Underscores have been replaced by periods for the benefit
of R.

aau1tm, am.non.hbw.sov.time
aau2tm, am.hov.two.time
aau3tm, am.hov.three.time
aa1tm1, am.hbw.inc.one.sov.time
aa1tm2, am.hbw.inc.two.sov.time
aa1tm3, am.hbw.inc.three.sov.time
aa1tm4, am.hbw.inc.four.sov.time
aau1cs, am.non.hbw.sov.generalized.cost
aau2cs, am.hov.two.generalized.cost
aau3cs, am.hov.three.generalized.cost
aa1cs1, am.hbw.inc.one.sov.generalized.cost
aa1cs2, am.hbw.inc.two.sov.generalized.cost
aa1cs3, am.hbw.inc.three.sov.generalized.cost
aa1cs4, am.hbw.inc.four.sov.generalized.cost
aau1ds, am.non.hbw.sov.distance
aau2ds, am.hov.two.distance
aau3ds, am.hov.three.distance
aa1ds1, am.hbw.inc.one.sov.distance
aa1ds2, am.hbw.inc.two.sov.distance
aa1ds3, am.hbw.inc.three.sov.distance
aa1ds4, am.hbw.inc.four.sov.distance
izdist, intrazonal.distance
izatim, intrazonal.time
termtm, terminal.time
abrdwa, am.walk.transit.boarding.time
atrtwa, am.total.transit.time
aivtwa, am.transit.in.vehicle.time
atwtwa, am.total.wait.time
aiwtwa, am.initial.wait.time
anbdwa, am.ave.number.boardings
aauxwa, am.auxiliary.transit.time
axfrwa, am.total.transfer.time
walkac, total.walk.access.time
afarwa, am.transit.fare.average
awlkdc, walk.mode.distance
awlktc, walk.mode.time
abkeds, bike.distance
abketm, bike.time
ivtda1, am.drive.transit.ivtt.income.one
auxda1, am.drive.transit.walk.time.income.one
twtda1, am.drive.transit.wait.time.income.one
nbdda1, am.drive.transit.ave.boardings.income.one
xfrda1, am.drive.transit.transf.time.income.one
ivtda2, am.drive.transit.ivtt.income.two
auxda2, am.drive.transit.walk.time.income.two
twtda2, am.drive.transit.wait.time.income.two
nbdda2, am.drive.transit.ave.boardings.income.two
xfrda2, am.drive.transit.transf.time.income.two
ivtda2, am.drive.transit.ivtt.income.two
ivtda3, am.drive.transit.ivtt.income.three
auxda3, am.drive.transit.walk.time.income.three
twtda3, am.drive.transit.wait.time.income.three
nbdda3, am.drive.transit.ave.boardings.income.three
xfrda3, am.drive.transit.transf.time.income.three
ivtda4, am.drive.transit.ivtt.income.four
auxda4, am.drive.transit.walk.time.income.four
twtda4, am.drive.transit.wait.time.income.four
iwtda4, am.drive.transit.init.wait.time.income.four
nbdda4, am.drive.transit.ave.boardings.income.four
xfrda4, am.drive.transit.transf.time.income.four
farda1, am.drive.transit.fare.income.one
farda2, am.drive.transit.fare.income.two
farda3, am.drive.transit.fare.income.three
farda4, am.drive.transit.fare.income.four
brdda4, am.drive.transit.boarding.time.income.four
brdda3, am.drive.transit.boarding.time.income.three
brdda2, am.drive.transit.boarding.time.income.two
brdda1, am.drive.transit.boarding.time.income.one
aa1tt1, am.drive.transit.sov.time.income.one
aa1tt2, am.drive.transit.sov.time.income.two
aa1tt3, am.drive.transit.sov.time.income.three
aa1tt4, am.drive.transit.sov.time.income.four
au2btm, am.hov.two.bidirectional.time
au3btm, am.hov.three.bidirectional.time
ah1btm, am.sov.bidirectional.time.income.one
ah2btm, am.sov.bidirectional.time.income.two
ah3btm, am.sov.bidirectional.time.income.three
ah4btm, am.sov.bidirectional.time.income.four
au2bcs, am.hov.two.bidirectional.cost
au3bcs, am.hov.three.bidirectional.cost
ah1bcs, am.sov.bidirectional.cost.income.one
ah2bcs, am.sov.bidirectional.cost.income.two
ah3bcs, am.sov.bidirectional.cost.income.three
ah4bcs, am.sov.bidirectional.cost.income.four
trtda1, am.drive.transit.total.time.income.one
trtda2, am.drive.transit.total.time.income.two
trtda3, am.drive.transit.total.time.income.three
trtda4, am.drive.transit.total.time.income.four
