function [quant,numb,likelyBS,totalTurns,turn,playerOfInterest,playerOfInterest2] = runTurns(dice,nsDice,quant,numb,nDice,bets,...
   traits,pHonestArray,turn,totalTurns,likelyBS,bs)
% loop that runs turns around the circle until "BS" is called
%
% Zach Kreft and Zach Safford
% April 7, 2019
while ~bs
    totalTurns = totalTurns+1; % increments total turns counter
    goDice = dice{turn}; % the hand of the player on turn
    % runs turns operated by betting function until "BS" is called
    [quant,numb,bs,turn,likelyBS] = betting(quant,numb,goDice,nDice,turn,bets,nsDice,likelyBS,totalTurns,traits,pHonestArray,bs); 
    if ~bs
        bets{1,totalTurns} = quant;
        bets{2,totalTurns} = numb;
    elseif bs
        bets{1,totalTurns} = 'BS';
        bets{2,totalTurns} = 'BS';
    end
    % saves the player number for this turn
    if turn >= 2 
        bets{3,totalTurns} = turn-1;
        playerOfInterest = turn-1;   
    else 
        bets{3,totalTurns} = 6;
        playerOfInterest = 6;
    end  
    if playerOfInterest >= 2
        playerOfInterest2 = playerOfInterest-1;
    else
        playerOfInterest2 = 6;
    end
    
    if bs
        if likelyBS(playerOfInterest) == 1
            likelyBS(playerOfInterest) = binocdf(bets(1,(totalTurns-1)),nDice,(1/3));
        else
            likelyBS(playerOfInterest) = (binocdf(bets(1,totalTurns-1),nDice,(1/3))+likelyBS(playerOfInterest))/2;
        end
    end
end