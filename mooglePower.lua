setImmersiveMode(true)
Settings:setCompareDimension(true, 1280)
Settings:set("MinSimilarity", 0.8)

local game = {
    battle = {
        dmw = {
            region = Region(1099, 458, 181, 136),

            mooglePower = {
                pattern = Pattern("battle.dmw.mooglePower.png")
            },
            luckyStars = {
                pattern = Pattern("battle.dmw.luckyStars.png")
            }
        },

        memory = {
            skip = {
                region = Region(1129, 647, 73, 50),
                pattern = Pattern("battle.memory.skip.png")
            }
        }
    },
    
    lobby = {
        savePoint = {
            region = Region(313, 191, 661, 411),
            pattern = Pattern("lobby.savePoint.png")
        }
    }
}

local controller = {
    l3 = Location(5, 630),
    r3 = Location(1230, 680),
    triangle = Location(1100, 260),
    square = Location(1030, 330),
    circle = Location(1169, 333)
}

local mooglePowerIsAvailable
repeat
    snapshot()
    mooglePowerIsAvailable = game.battle.dmw.region:exists(game.battle.dmw.mooglePower.pattern)

    if game.battle.dmw.region:exists(game.battle.dmw.luckyStars.pattern) then
        toast("Lucky Stars")
        click(controller.triangle)
    elseif game.battle.memory.skip.region:exists(game.battle.memory.skip.pattern) then
        toast("Skip")
        click(controller.triangle)
    end

    usePreviousSnap(false)
until mooglePowerIsAvailable

toast("Moogle Power")
touchDown(controller.l3)
touchDown(controller.r3)
touchUp(controller.l3)
touchUp(controller.r3)

while not game.lobby.savePoint.region:exists(game.lobby.savePoint.pattern) do
    click(controller.triangle)
    click(controller.square)
    click(controller.circle)
end

vibrate(3 --[[ seconds ]])
print("Finished!")