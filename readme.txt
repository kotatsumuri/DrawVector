全ての関数外
Vector vn; ベクトルを宣言
Angle an; 表示させたい角を宣言
Scale 倍率

setup
vn = new Vector(name); Vectorオブジェクトを生成 nameにその名前を入れる
vn.setLengthAndAngle(length,angle); 長さと角度からベクトルを生成
vn.setPosition(x,y);座標位置からベクトルを生成
an = new Angle(base.angle,notbase.angle);角を生成 baseに基準角度,notbaseに基準じゃない角度

draw 
vn.drawVector();ベクトルを描く
an.drawAngle();角を描く

あとはお好みで調整してください

kawakami shota
