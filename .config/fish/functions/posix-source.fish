# Thanks to Michael Lewandowski: http://lewandowski.io/2016/10/fish-env/
function posix-source
	for i in (cat $argv)
		if string match --invert "#*" $i > /dev/null; and test -n $i
			set arr (echo $i |tr = \n)
			set clean (string trim -c \" $arr[2])
			set -gx $arr[1] $clean
		end
	end
end