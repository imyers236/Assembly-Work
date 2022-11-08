hw6_1:
	gcc -c -g hw6_1.s
	ld hw6_1.o -o hw6_1
	./hw6_1

hw6_2:
	gcc -c -g hw6_2.s
	ld hw6_2.o -o hw6_2
	./hw6_2

clean:
	rm  *.o hw6_1 hw6_2