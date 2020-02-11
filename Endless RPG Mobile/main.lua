-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local playerDead = false

local enemyDead = false

local Playerattacked = false

local hello = "A monster stands before you!"

local attack = "Attack"

local heal = "Heal: "

local itemNum = 5

local monsters = {"CamelC1_Idle1.png"}

local chosenMonster = monsters[math.random(1,#monsters)]

local options = {
    width = 16,
    height = 16,
    numFrames = 19
  }

local equipment = graphics.newImageSheet("Gear.png",options)

local background = display.newImageRect("background.png",360,570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText(hello,display.contentCenterX,20,native.systemFont,20)
tapText:setFillColor(0,0,0)

local platform = display.newImageRect("groundspr_0009_Group-1.png",300,50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-175

local samplemob = display.newImageRect(chosenMonster,112,112)
samplemob.x = display.contentCenterX
samplemob.y = display.contentCenterY

local weapon = display.newImageRect(equipment, 1,75,75)
weapon.x = display.contentWidth-250
weapon.y = display.contentHeight-95

local AttackText = display.newText(attack,60,425,native.systemFont,20)
AttackText:setFillColor(0,0,0)

local HealText = display.newText(heal,240,425,native.systemFont,20)
HealText:setFillColor(0,0,0)

local healNum = display.newText(itemNum,270,425,native.systemFont,20)
healNum:setFillColor(0,0,0)

local healing = display.newImageRect("Apple.png",75,75)
healing.x = display.contentWidth-75
healing.y = display.contentHeight-100

local hp = 100

local HPText = "HP:"

local enemyMax = 5

local enemyHP = enemyMax

local enemyStrength = 0

local HPdisplay = display.newText(HPText,140,425,native.systemFont,20)
HPdisplay:setFillColor(0,0,0)

local HPnum = display.newText(hp,180,425,native.systemFont,20)
HPnum:setFillColor(0,0,0)

local function nextMove()
  Playerattacked = false
  tapText.text = "What are you gonna do?"
end

local function GameOver()
  tapText.text = "You are dead now. Game Over..."
end


local function camelattack()
  local MissTexts = {"The Camel fell short on its attack","The Camel bonks his head\nas it miss its attack","The Camel is starting to\nregret being bodyless..."}
  local action = math.random(4)
  if action == 1 then
    tapText.text = MissTexts[math.random(1,#MissTexts)]
    timer.performWithDelay(3000,nextMove,1)
  elseif action == 2 then
    tapText.text = "The Camel drank some water\nto heal itself!"
    enemyHP = enemyHP + (1 + (1*enemyStrength))
    timer.performWithDelay(3000,nextMove,1)
  elseif action == 3 then
    tapText.text = "The Camel hits you with a headbutt!"
    hp = hp - (10 + (5*enemyStrength))
    HPnum.text = hp
    if hp <= 0 then
      playerDead = true
      timer.performWithDelay(1000,GameOver,1)
    else
      timer.performWithDelay(3000,nextMove,1)
    end
  else
    tapText.text = "Ouch!\nThe Camel landed a critical hit..."
    hp = hp - (2*(10 + (5*enemyStrength)))
    HPnum.text = hp
    if hp <= 0 then
      playerDead = true
      timer.performWithDelay(1000,GameOver,1)
    else
      timer.performWithDelay(3000,nextMove,1)
    end
  end
end

local function respawnMonster()
  enemyDead = false
  enemyMax = enemyMax + 5
  enemyHP = enemyMax
  enemyStrength = enemyStrength + 1
  samplemob = display.newImageRect(chosenMonster,112,112)
  samplemob.x = display.contentCenterX
  samplemob.y = display.contentCenterY
  tapText.text = "Oh wait, it's back..."
  timer.performWithDelay(3000,nextMove,1)
end

local function testattack()
  local attackTexts = {"You attack and damaged the monster!","You damaged the monster\nwith a swift stike!","You give the monster a low blow.\nOuch..."}
  if playerDead == false and Playerattacked == false and enemyDead == false then
    Playerattacked = true
    enemyHP = enemyHP - 1
    if enemyHP <= 0 then
      enemyDead = true
      display.remove(samplemob)
      tapText.text = "You defeated the monster!"
      timer.performWithDelay(5000,respawnMonster,1)
    else
      tapText.text = attackTexts[math.random(1,#attackTexts)]
      timer.performWithDelay(3000,camelattack,1)
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
      hp = hp + 30
      if hp > 100 then
        hp = 100
      end
      HPnum.text = hp
      tapText.text = "You healed yourself."
    end
  end
end

healing:addEventListener("tap",testheal)
weapon:addEventListener("tap",testattack)
