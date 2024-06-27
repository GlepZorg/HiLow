CC = gcc
CFLAGS = -Wall -O2
AS = as
LD = ld

hilow: main.o generate_number.o get_user_guess.o
	$(CC) $(CFLAGS) -o hilow main.o generate_number.o get_user_guess.o

main.o: main.s
	$(AS) -o main.o main.s

generate_number.o: generate_number.s
	$(AS) -o generate_number.o generate_number.s

get_user_guess.o: get_user_guess.s
	$(AS) -o get_user_guess.o get_user_guess.s

clean:
	rm -f *.o hilow

