Config = {}

Config.ServerEventname = "oiltwo" 
Config.Zone = {
	Pos = {  
		x = 2820.63,
		y = -633.39,
		z = 2.31
	},
	Blips = {
		Id = 478,
		Color = 55,
		Size = 1.2,
		Text = '<font face="font4thai">[งาน] เเร่ตะกั่ว</font>'
	}
}

--ไอเท็มที่ใช้ทำงาน 

-- Config.Useitem = false         -- true  = ใช้ไอเท็มเก็บ  false = ไม่ใช้ไอเท็มเก็บ
-- Config.itemworking = "c_job"  -- ไอเท็มที่ใช้ทำงาน
Config.x2 = "cardx2"             -- ไอเท็มที่ใช้ทำงาน x2 
Config.deleteobject = 1          -- % = 1 = 100%, 2 = 50%, 3 = 33%, 4 = 25%, 5 = 20%
Config.radarpick = 2.0           -- ระยะในการกด เินชนแล้ว เก็บ

-- ไอเท็มที่จะได้รับ 
Config.ItemCount = {1,2}         -- จำนวนที่จะได้
Config.ItemName = "lead_ore"    -- ไอเทมที่ดรอป
Config.timepick = 4.0            -- เวลาในการทำ วินาที
Config.ItemBonus = {             -- ไอเท็มโบนัส
	{
		ItemName = "exp",        -- ชื่อไอเท็ม
		ItemCount = 1,  
		Percent = 100            -- เปอร์เซ็น
	},

}

-- Prop  
Config.object = 'prop_rock_1_i' -- ออฟเจ็คบนพื้น
Config.prophand = ''                        -- พร้อบถือ 
Config.Animation1 = 'missarmenian3_gardener'-- ท่าตอนเก็บ
Config.Animation2 = 'idle_a'                -- ท่าตอนเก็บ
Config.spawnobj = 15                        -- จำนวน ออฟเจ็คบนพื้น
Config.grandZ = {58.51, 58.52, 58.53, 58.54, 58.55, 58.56, 58.57, 58.58, 58.59, 58.60, 58.61, 58.62}  
Config["spawnrandomX"] = {-20, 20}          --พิกัดสอปอน object x
Config["spawnrandomY"] = {-20, 20}          -- พิกัดสอปอน object y


--ข้อคาม + เสียง  
Config.loading = "mythic_progbar:client:progress" -- หลอดโหลด
Config.textdoing = "กำลังเก็บน้ำมัน.."
Config.Noitemwork = " <center><b style='color:white'> คุณไม่มี อุปกรณ์ทำงาน</b><br /></center>"
Config.ItemFull = 'น้ำมัน ของคุณเต็ม!'              -- ตัวหนังสือตอนของเต็ม
Config.ItemBonusFull = 'ไอเท็มโบนัส เต็ม !'          -- ตัวหนังสือตอนของเต็ม
Config.sound = "pickaxe1"
Config.sizetext = 0.55  -- ขนาดของตัวหนังสือ
Config.textpickup = '<font face="font4thai">~b~เดินชนเพื่อเก็บ</font>' -- ตัวหนังสือ ตอนเก็บ
Config.loop = 1000 --- ปรับ 1000 เช็คทุก 1 วิ วิ่ง 0.00 // ปรับ 69.40 เช็คตลอด วิ่ง 0.00-0.01

-- พื้นหลัง ของตัวหนังสือ
Config.Textz = {  
	notz = {	
		big = 0.04,  --ความใหญ่
		long = 450,  -- ความยาว
		K = 130      -- ความเข้ม
	}
}
Config.playsound = false  --- ถ้าใช้เป็นค่อยเปิดนะครับ >.<