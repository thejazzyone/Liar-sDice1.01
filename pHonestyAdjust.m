function [pHonestArray,lies,truths] = pHonestyAdjust(bets,dice,pHonestArray,lies,truths)
[height, length] = size(bets);
identityBS = bets(2,length-1);

for i = 1:length-1
    betIdentity = bets(2,i);
    if betIdentity == identityBS
        playerNumber = bets(3,i);
        diceOfPlayer = dice(1,playerNumber);
        vectorLength = length(diceOfPlayer);
        for j = 1:vectorLength
            die = diceOfPlayer(j);
            if die == identityBS || die == 1
                contains = true;
                lies(playerNumber) = lies(playerNumber)+1;
            else
                contains = false;
                truths(playerNumber) = truths(playerNumber)+1;
            end
        end
        if contains
            truthsN = truths(playerNumber);
            honestValue = pHonestArray(playerNumber);
            honestValue = ((1-honestValue)/(2+truthsN))+honestValue;
            pHonestArray(playerNumber) = honestValue;
        else
            liesN = lies(playerNumber);
            honestValue = pHonestArray(playerNumber);
            honestValue = honestValue-((1-honestValue)/(2+liesN));
            pHonestArray(playerNumber) = honestValue;
        end
    end
end