local A, L = ...
local addonpath = "Interface\\AddOns\\"..A.."\\"
local owsound = addonpath.."sfx\\ow\\"

-- Matches exact IDs
L.SFXCastSuccessSpellIDs = {
    -- Priest
    [47788] = owsound.."watchingoveryou.ogg", -- Guardian Spirit
    [64843] = owsound.."letsdropthebeat.ogg", -- Divine Hymn
    [2006] = owsound.."heroesneverdie.ogg", -- Resurrection
    [212036] = owsound.."heroesneverdie.ogg", -- Mass Resurrection
    [73325] = owsound.."getback.ogg", -- Leap of Faith
    [62618] = owsound.."barrierup.ogg", -- Power Word: Barrier
    [15487] = owsound.."shutup.ogg", -- Silence
    [193223] = owsound.."junkratlaugh.ogg", -- Surrender to Madness
    -- Rogue
    [51690] = owsound.."die.ogg", -- Killing Spree
    [200806] = owsound.."didthatsting.ogg", -- Exsanguinate
    [121471] = owsound.."deathcomes.ogg", -- Shadow Blades
    [152150] = owsound.."deathfromabove.ogg", -- Death From Above
    [185767] = owsound.."justice.ogg", -- Cannonball Barrage
    [36554] = owsound.."repos.ogg", -- Shadowstep
    [79140] = owsound.."iseeyou.ogg", -- Vendetta
    [2983] = owsound.."illraceya.ogg", -- Sprint
    -- Hunter
    [120360] = owsound.."ivegotyou.ogg", -- Barrage
    [194855] = owsound.."fireinthehole.ogg", -- Dragonsfire Grenade
    -- Hunter Pets
    [159931] = owsound.."heroesneverdie.ogg", -- Gift of Chi-Ji
    [126393] = owsound.."heroesneverdie.ogg", -- Eternal Guardian
    [90355] = owsound.."highnoon.ogg", -- Ancient Hysteria
    [160452] = owsound.."highnoon.ogg", -- Netherwinds
    -- Druid
    [6795] = owsound.."doihaveyourattention.ogg", -- Growl
    [740] = owsound.."tranquility.ogg", -- Tranquility
    [61336] = owsound.."dontbeshy.ogg", -- Survival Instincts
    [106898] = owsound.."speedboost.ogg", -- Stampeding Roar
    [102280] = owsound.."blink.ogg", -- Displacer Beast
    [102401] = owsound.."charge.ogg", -- Wild Charge
    [212040] = owsound.."heroesneverdie.ogg", -- Revitalize
    [50769] = owsound.."heroesneverdie.ogg", -- Revive
    [20484] = owsound.."heroesneverdie.ogg", -- Rebirth
    [1850] = owsound.."illraceya.ogg", -- Dash
    -- Shaman
    [2825] = owsound.."highnoon.ogg", -- Bloodlust
    [32182] = owsound.."highnoon.ogg", -- Heroism
    [2008] = owsound.."heroesneverdie.ogg", -- Ancestral Spirit
    [212048] = owsound.."heroesneverdie.ogg", -- Ancestral Vision
    [20608] = owsound.."heroesneverdie.ogg", -- Reincarnation
    [196884] = owsound.."charge.ogg", -- Feral Lunge
    -- Mage
    [80353] = owsound.."highnoon.ogg", -- Time Warp
    [1953] = owsound.."blink.ogg", -- Blink
    [190319] = owsound.."moltencore.ogg", -- Combustion
    [45438] = owsound.."omg.ogg", -- Ice Block
    [12472] = owsound.."meiult.ogg", -- Icy Veins
    -- Paladin
    [204150] = owsound.."getbehindme.ogg", -- Aegis of Light
    [7328] = owsound.."heroesneverdie.ogg", -- Redemption
    [212056] = owsound.."heroesneverdie.ogg", -- Absolution
    [115750] = owsound.."holdupnow.ogg", -- Blinding Light
    [853] = owsound.."justicewillbedone.ogg", -- Hammer of Justice
    [1022] = owsound.."beshielded.ogg", -- Blessing of Protection
    -- Warrior
    [198304] = owsound.."charge.ogg", -- Intercept
    [100] = owsound.."charge.ogg", -- Charge
    -- Death Knight
    [49576] = owsound.."anchors.ogg", -- Death Grip
    [61999] = owsound.."heroesneverdie.ogg", -- Raise Ally
    [212552] = owsound.."wraithwalk.ogg", -- Wraith Walk
    -- Monk
    [212051] = owsound.."heroesneverdie.ogg", -- Reawaken
    [115178] = owsound.."heroesneverdie.ogg", -- Resuscitate
    -- Warlock
    [152108] = owsound.."onemanapocalypse.ogg", -- Cataclysm
    -- Demon Hunter
    [198013] = owsound.."angelofdeath.ogg", -- Eye Beam
    [196718] = owsound.."thedarkness.ogg", -- Darkness
}

-- Most of these have different versions with different spell IDs, matches all their names
L.SFXCastSuccessSpellNames = {
    -- Mage
    [GetSpellInfo(118)] = owsound.."wereallanimals.ogg", -- Polymorph
    -- Paladin
    [GetSpellInfo(190784)] = owsound.."backinthesaddle.ogg", -- Divine Steed
    -- Death Knight
    [GetSpellInfo(108194)] = owsound.."squealforme.ogg", -- Asphyxiate
    -- Other
    [GetSpellInfo(28730)] = owsound.."shutup.ogg", -- Arcane Torrent
}

L.SFXAuraAppliedSpellNames = {
    -- Hunter
    [GetSpellInfo(187650)] = owsound.."gotcha.ogg", -- Freezing Trap
}
