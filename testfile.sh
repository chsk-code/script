#! /bin/bash
echo "Enter you choice : 1) Release 2) Directory"
echo " your choice is $1 "
if [ $1 == 1 ]
then
  echo "Enter release in format : path oldrelease newrelease"
  path=`echo $2 | awk '{ print $1 }'`
  oldrel=`echo $2 | awk '{ print $2 }'`
  newrel=`echo $2 | awk '{ print $3 }'`
elif [ $1 == 2 ]
then
  echo "Enter directory in format : path release oldfolder newfolder"
  path=`echo $2 | awk '{ print $1 }'`
  release=`echo $2 | awk '{ print $2 }'`
  olddir=`echo $2 | awk '{ print $3 }'`
  newdir=`echo $2 | awk '{ print $4 }'`
else
  echo " wrong choice"
fi

if [ $1 == 1 ]; then
crelease=$oldrel
nrelease=$newrel
if [ -d $path/$nrelease ]; then
  echo "Directory aready exists"
else
  cp -rvf $path/$oldrel $path/$newrel
  cp -rvf $path/hieradata/$oldrel  $path/hieradata/$newrel
  cd $path/$newrel
crelease=`echo _$oldrel | sed 's/\./_/g'`
  echo "crelease:$crelease"
  nrelease=`echo _$newrel | sed 's/\./_/g'`
  echo "nrelease:$nrelease"
  for file in *$crelease
  do
   mv "$file" "${file/$crelease/$nrelease}"
  done
  cd $path/hieradata/$newrel
  for file in *$crelease
  do
   mv "$file" "${file/$crelease/$nrelease}"
  done
cd $path/hieradata/$newrel
  for file in *$crelease
  do
   mv "$file" "${file/$crelease/$nrelease}"
  done
  cd $path/$newrel
  find ./ -type f -exec sed -i 's/'$crelease'/'$nrelease'/g' {} \;
  find ./ -type f -exec sed -i 's/'$oldrel'/'$newrel'/g' {} \;
fi
elif [ $1 == 2 ]; then
echo " started creating folder"
cdirectory=$olddir
ndirectory=$newdir
if [ -d $path/$release/$ndirectory ]; then
  echo "Directory aready exists"
else
   cp -rvf $path/$release/$olddir $path/$release/$newdir
   cp -rvf $path/hieradata/$release/$olddir  $path/hieradata/$release/$newdir
   cd $path/$release/$newdir
   cdirectory=`echo _$olddir | sed 's/\./_/g'`
   echo "cdirectory:$cdirectory"
   ndirectory=`echo _$newdir | sed 's/\./_/g'`
   echo "ndirectory:$ndirectory"
fi
else
 echo "nothing to do"
fi
