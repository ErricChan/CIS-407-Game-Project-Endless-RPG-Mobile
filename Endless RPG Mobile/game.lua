
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local weaponupgrade
local armorupgrade
local healupgrade

local tapText

local playerDead = false

local enemyDead = false

local Playerattacked = false

local poisoned = false

local poisonturns = 0

local hello = "A monster stands before you!"

local attack = "Attack"

local heal = "Heal: "

local itemNum = 5

local weaponlevel = 1

local playerstrength = 1

local healpower = 0

local defenselevel = 1

local defensepower = 0

local kills = 0

local monsters = {"CamelC1_Idle1.png","FrogC1_Idle1.png","CursedVaseC1_Idle1.png", "MultiFaceC1_Idle1.png","NightmareMirrorC1_Idle1.png","SnailC1_Idle1.png"}

local chosenMonster = monsters[math.random(1,#monsters)]

local options = {
    width = 16,
    height = 16,
    numFrames = 19
  }

local equipment = graphics.newImageSheet("Gear.png",options)

local hp = 100

local HPText = "HP:"

local enemyMax = 5

local enemyHP = enemyMax

local enemyStrength = 0

local killsText = "Kills: "

local killnum

local HPnum

local healnum

local samplemob

local function nextMove()
  Playerattacked = false
  tapText.text = "What are you gonna do?"
end

local function GameOver()
  tapText.text = "You are dead now. Game Over..."
  display.remove(samplemob)
  composer.setVariable("finalScore",kills)
  composer.gotoScene("highscores",{ time=1600, effect="crossFade" })
end


local function camelattack()
  local MissTexts = {"The Camel fell short on its attack","The Camel bonks his head\nas it miss its attack","The Camel is starting to\nregret being bodyless...","The Camel is nodding off...","The Camel's trying to wave a\nwhite flag, but realizes\nit has no hands..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Camel drank some water\nto heal itself!"
    enemyHP = enemyHP + (1 + (1*enemyStrength))
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 3 then
    tapText.text = "The Camel hits you with a headbutt!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Camel hits you,\nbut it did no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nThe Camel lands a critical hit..."
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Camel lands a critical hit...\nBut it did nothing!"
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end
end

local function frogattack()
  local MissTexts = {"The Frog swings its silverware\nat you, but misses...","The Frog is currently\ndistracted by a fly...", "The Frog flings its tongue at you,\nbut you dodge it...","The Frog trips on itself\nwhen it tries to attack you..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Frog attacks you furiously\nwith its silverware!"
    local NumberOfHits = math.random(5)
    local damage = NumberOfHits* ((3*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Frog unleashes its attack flurry,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  elseif action == 3 then
    tapText.text = "The Frog smacks you with its tongue!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Frog's tongue smacks you,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nThe Frog landed a critical hit..."
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Frog landed a critical hit...\nBut it did nothing!"
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end
end

local function vaseattack()
  local MissTexts = {"The Cursed Vase is just\nstanding there...menacingly!","The Cursed Vase does nothing...","Nothing seems to be happening...","The feeling when you don't know\nhow to make comments about\na Cursed Vase...", "Just what is this Vase up to,\nanyways?..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Vase fires a dark energy blast\nupon you, ignoring some of\nyour defense!"
    local damage = 10 + ((5*enemyStrength) - (5*defensepower))
    if damage <= 0 then
      tapText.text = "The Vase fires a dark energy blast,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  elseif action == 3 then
    tapText.text = "You suddenly feel pain!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "You felt something hit you,\nbut you didn't feel anything..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nYou somehow got hit with a critical!"
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "You felt a critical hit somewhere,\nbut you didn't take damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end  
end

local function faceattack()
  local MissTexts = {"The eyes on this monster is\njust staring at you...","Some of eyes swing at you,\nbut they collide with\n each other midway...","The monster's eyes\ngot blinded by dust!...","The monster blinks\nvery absently...","The eyestocks on this monster\nare getting tangled!"}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The monster fires multiple beams,\nignoring some of your defense!"
    local NumberOfHits = math.random(5)
    local damage = NumberOfHits* ((3*enemyStrength) - (5*defensepower))
    if damage <= 0 then
      tapText.text = "It fires multiple beams...\nbut you take no damage."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  elseif action == 3 then
    tapText.text = "The monster hits you with its eyes!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The monster landed a hit on you,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nYou got hit with a critical!"
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The monster lands a critcal hit,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end 
end

local function mirrorattack()
  local MissTexts = {"The Mirror is just gleaming at you...","The shadow attacks you,\nbut it swings wide...","Can you stop admiring\nyourself?","It seems to be manifesting\nsomething, but it's failing...","Nothing seems to be happening..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Mirror creates a copy of you,\nwhich attacks with a powerful strike!"
    local damage = 5*(enemyStrength+weaponlevel) - (10*defensepower)
    if damage <= 0 then
      tapText.text = "A mirrored copy of you attacks,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  elseif action == 3 then
    tapText.text = "The shadow damages you with\na quick slash!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The shadow lands a slash,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nYou got hit with a critical!"
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Mirror lands a critical hit,\nbut you take no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end 
end


local function snailattack()
  local MissTexts = {"The Snail charges at you...\nit's taking forever...","The Snail is reacting very\nslowly to your attacks","The Snail is coming at you!...\nWatch out!...","The way the Snail is charging\nat you is rather sad,\nyet cute at the same time...","The Snail is forgetting\nthat it has a cannon on\nits back..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(2000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Snail fires its cannon,\n which damages and\npoisons you!"
    local damage = 5*(enemyStrength) - (10*defensepower)
    if damage <= 0 then
      tapText.text = "The Snail's cannon didn't do\ndamage, but it poisons you..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    poisoned = true
    poisonturns = 3
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      poisoned = false
      poisonturns = 0
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  elseif action == 3 then
    tapText.text = "The Snail bites your leg,\nand it hurts!"
    local damage = (10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Snail nibbles on your leg,\ndealing no damage..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nYou got hit with a critical!"
    local damage = 2*(10 + (5*enemyStrength) - (10*defensepower))
    if damage <= 0 then
      tapText.text = "The Snail lands a critical by\ncrawling on your leg,\nwhich does nothing..."
      damage = 0
    end
    hp = hp - damage
    HPnum.text = hp
    if hp <= 0 then
      hp = 0
      HPnum.text = hp
      playerDead = true
      timer.performWithDelay(2000,GameOver,1)
    else
      timer.performWithDelay(2000,nextMove,1)
    end
  end   
end

local function poison()
  hp = hp - 10
  HPnum.text = hp
  tapText.text = "The poison takes effect,\ndamaging your health."
  poisonturns = poisonturns - 1
  if hp <= 0 then
    if poisonturns <= 0 then
      poisoned = false
      tapText.text = "The poison wears off,\nbut not before dealing its\n last poison damage effect."
    end
    hp = 0
    HPnum.text = hp
    playerDead = true
    poisoned = false
    poisonturns = 0
    timer.performWithDelay(2000,GameOver,1)
  else
    if poisonturns <= 0 then
      poisoned = false
      tapText.text = "The poison wears off,\nbut not before dealing its\n last poison damage effect."
    end
    timer.performWithDelay(2000,snailattack,1)
  end
end

local function respawnMonster()
  enemyDead = false
  enemyMax = enemyMax + 5
  enemyHP = enemyMax
  enemyStrength = enemyStrength + 1
  chosenMonster = monsters[math.random(1,#monsters)]
  samplemob = display.newImageRect(chosenMonster,112,112)
  samplemob.x = display.contentCenterX
  samplemob.y = display.contentCenterY
  tapText.text = "Another monster has appeared!"
  poisoned = false
  poisonturns = 0
  itemNum = 5
  healNum.text = itemNum
  hp = 100
  HPnum.text = hp
  timer.performWithDelay(2000,nextMove,1)
end

local function weaponup()
  tapText.text = "Your attack power has increased!"
  weaponlevel = weaponlevel + 1
  if weaponlevel > 5 then
    tapText.text = "Your attack power is maxed out!"
  end
  playerstrength = playerstrength * 2
  display.remove(weaponupgrade)
  display.remove(armorupgrade)
  display.remove(healupgrade)
  
  timer.performWithDelay(2000,respawnMonster,1)
end

local function armorup()
  tapText.text = "Your defense power has increased!"
  defenselevel = defenselevel + 1
  if defenselevel > 5 then
    tapText.text = "Your defense power is maxed out!"
  end
  defensepower = defensepower + 1
  display.remove(weaponupgrade)
  display.remove(armorupgrade)
  display.remove(healupgrade)
  
  timer.performWithDelay(2000,respawnMonster,1)
end

local function healingup()
  tapText.text = "Your apples' healing power\nhas increased!"
  healpower = healpower + 10
  if healpower >= 50 then
    tapText.text = "Your apples' healing power\nis maxed out!"
  end
  display.remove(weaponupgrade)
  display.remove(armorupgrade)
  display.remove(healupgrade)
  
  timer.performWithDelay(2000,respawnMonster,1)
end

local function upgradeSelf()
  if weaponlevel > 5 and defenselevel > 5 and healpower >= 50 then
    timer.performWithDelay(100,respawnMonster,1)
  else
    tapText.text = "Choose an upgrade"
    if weaponlevel <= 5 then
      weaponupgrade = display.newImageRect(equipment,1+weaponlevel,75,75)
      weaponupgrade.x = display.contentWidth-250
      weaponupgrade.y = display.contentHeight-250
      weaponupgrade:addEventListener("tap",weaponup)

    end
    
    if defenselevel <= 5 then
      armorupgrade = display.newImageRect(equipment,19-defenselevel,75,75)
      armorupgrade.x = display.contentCenterX
      armorupgrade.y = display.contentHeight-250
      armorupgrade:addEventListener("tap",armorup)
    end
    
    if healpower < 50 then
      healupgrade = display.newImageRect("Jam.png",75,75)
      healupgrade.x = display.contentWidth-75
      healupgrade.y = display.contentHeight-250
      healupgrade:addEventListener("tap",healingup)
    end
  end
end

local function testattack()
  local attackTexts = {"Your attack struck the monster!","You damaged the monster\nwith a swift stike!","You give the monster a low blow.\nOuch...","You swing your weapon wildy\nand somehow hit the monster.","You poke the monster...\nWhich somehow damages it...","You give the monster a slap instead."}
  if playerDead == false and Playerattacked == false and enemyDead == false then
    Playerattacked = true
    local critchance = math.random(4)
    if critchance == 4 then
      enemyHP = enemyHP - 2*(playerstrength)
      if enemyHP <= 0 then
        enemyDead = true
        display.remove(samplemob)
        tapText.text = "You defeated the monster!"
        kills = kills + 1
        killnum.text = kills
        timer.performWithDelay(3000,upgradeSelf,1)
      else
        tapText.text = "You landed a critical hit!"
        if chosenMonster == "CamelC1_Idle1.png" then
          timer.performWithDelay(2000,camelattack,1)
        elseif chosenMonster == "FrogC1_Idle1.png" then
          timer.performWithDelay(2000,frogattack,1)
        elseif chosenMonster == "CursedVaseC1_Idle1.png" then
          timer.performWithDelay(2000,vaseattack,1)
        elseif chosenMonster == "MultiFaceC1_Idle1.png" then
          timer.performWithDelay(2000,faceattack,1)
        elseif chosenMonster ==  "NightmareMirrorC1_Idle1.png" then
          timer.performWithDelay(2000,mirrorattack,1)
        elseif chosenMonster ==  "SnailC1_Idle1.png" then
          if poisoned == true then
            timer.performWithDelay(2000,poison,1)
          else
            timer.performWithDelay(2000,snailattack,1)
          end
        end
      end
    else
      enemyHP = enemyHP - playerstrength
      if enemyHP <= 0 then
        enemyDead = true
        display.remove(samplemob)
        tapText.text = "You defeated the monster!"
        kills = kills + 1
        killnum.text = kills
        timer.performWithDelay(3000,upgradeSelf,1)
      else
        tapText.text = attackTexts[math.random(1,#attackTexts)]
        if chosenMonster == "CamelC1_Idle1.png" then
          timer.performWithDelay(2000,camelattack,1)
        elseif chosenMonster == "FrogC1_Idle1.png" then
          timer.performWithDelay(2000,frogattack,1)
        elseif chosenMonster == "CursedVaseC1_Idle1.png" then
          timer.performWithDelay(2000,vaseattack,1)
        elseif chosenMonster == "MultiFaceC1_Idle1.png" then
          timer.performWithDelay(2000,faceattack,1)
        elseif chosenMonster ==  "NightmareMirrorC1_Idle1.png" then
          timer.performWithDelay(2000,mirrorattack,1)
        elseif chosenMonster ==  "SnailC1_Idle1.png" then
          if poisoned == true then
            timer.performWithDelay(2000,poison,1)
          else
            timer.performWithDelay(2000,snailattack,1)
          end
        end
      end
    end
  end
end

local function testheal()
  if playerDead == false and enemyDead == false and Playerattacked == false then
    if itemNum <= 0 then
      tapText.text = "Oops, you used up all your apples..."
    elseif hp >= 100 then
      tapText.text = "You're at full health."
    else
      itemNum = itemNum - 1
      healNum.text = itemNum
      hp = hp + (30 + healpower)
      if hp > 100 then
        hp = 100
      end
      HPnum.text = hp
      tapText.text = "You healed yourself.\nNow attack!...\nOr heal again."
    end
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local background = display.newImageRect(sceneGroup,"background.png",360,570)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  tapText = display.newText(sceneGroup,hello,display.contentCenterX,20,native.systemFont,20)
  tapText:setFillColor(0,0,0)

  local platform = display.newImageRect(sceneGroup,"groundspr_0009_Group-1.png",300,50)
  platform.x = display.contentCenterX
  platform.y = display.contentHeight-175

  samplemob = display.newImageRect(sceneGroup,chosenMonster,112,112)
  samplemob.x = display.contentCenterX
  samplemob.y = display.contentCenterY

  local weapon = display.newImageRect(sceneGroup,equipment, 1,75,75)
  weapon.x = display.contentWidth-250
  weapon.y = display.contentHeight-95

  local AttackText = display.newText(sceneGroup,attack,60,425,native.systemFont,20)
  AttackText:setFillColor(0,0,0)

  local HealText = display.newText(sceneGroup,heal,240,425,native.systemFont,20)
  HealText:setFillColor(0,0,0)

  healNum = display.newText(sceneGroup,itemNum,270,425,native.systemFont,20)
  healNum:setFillColor(0,0,0)

  local healing = display.newImageRect(sceneGroup,"Apple.png",75,75)
  healing.x = display.contentWidth-75
  healing.y = display.contentHeight-100
  
  local killsdisplay = display.newText(sceneGroup,killsText,140,450,native.systemFont,20)
  killsdisplay:setFillColor(0,0,0)

  killnum = display.newText(sceneGroup,kills,180,450,native.systemFont,20)
  killnum:setFillColor(0,0,0)

  local HPdisplay = display.newText(sceneGroup,HPText,140,425,native.systemFont,20)
  HPdisplay:setFillColor(0,0,0)

  HPnum = display.newText(sceneGroup,hp,180,425,native.systemFont,20)
  HPnum:setFillColor(0,0,0)
  
  healing:addEventListener("tap",testheal)
  weapon:addEventListener("tap",testattack)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
    composer.removeScene("game")
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
