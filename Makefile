NAME = client
NAMESRV = server
LIBNAME = libft.a
SRCCL = client.c
SRCSRV = server.c
SRCBONUSCL = client_bonus.c
SRCBONUSSRV = server_bonus.c
OBJCL = $(SRCCL:.c=.o)
OBJSRV = $(SRCSRV:.c=.o)
OBJBONUSCL = $(SRCBONUSCL:.c=.o)
OBJBONUSSRV = $(SRCBONUSSRV:.c=.o)

FLAGS = -Wall -Wextra -Werror
NONE='\033[0m'
GREEN='\033[32m'
GRAY='\033[2;37m'
CURSIVE='\033[3m'

all: $(NAME) $(NAMESRV)

$(NAME): $(OBJCL) $(LIBNAME)
	@echo $(CURSIVE)$(GRAY) "     - Compiling $(NAME)..." $(NONE)
	@gcc $(FLAGS) $(OBJCL) $(LINKS) -o $(NAME) libft.a
	@echo $(GREEN)"- Compiled -"$(NONE)

$(NAMESRV): $(OBJSRV) $(LIBNAME)
	@echo $(CURSIVE)$(GRAY) "     - Compiling $(NAMESRV)..." $(NONE)
	@gcc $(FLAGS) $(OBJSRV) $(LINKS) -o $(NAMESRV) libft.a
	@echo $(GREEN)"- Compiled -"$(NONE)

$(LIBNAME):
	@echo $(CURSIVE)$(GRAY) "     - Compiling LIBFT $(LIBNAME)..." $(NONE)
	@$(MAKE) -C ./libft all
	@cp ./libft/libft.a $(LIBNAME)
	@echo $(GREEN)"- Compiled -"$(NONE)

$(OBJCL): $(SRCCL)
	@echo $(CURSIVE)$(GRAY) "     - Making object files..." $(NONE)
	@gcc $(FLAGS) -c $(SRCCL)

$(OBJSRV): $(SRCSRV)
	@echo $(CURSIVE)$(GRAY) "     - Making object files..." $(NONE)
	@gcc $(FLAGS) -c $(SRCSRV)

$(OBJBONUSCL): $(SRCBONUSCL)
	@echo $(CURSIVE)$(GRAY) "     - Making object files..." $(NONE)
	@gcc $(FLAGS) -c $(SRCBONUSCL)

$(OBJBONUSSRV): $(SRCBONUSSRV)
	@echo $(CURSIVE)$(GRAY) "     - Making object files..." $(NONE)
	@gcc $(FLAGS) -c $(SRCBONUSSRV)

bonus: $(OBJBONUSCL) $(OBJBONUSSRV) $(LIBNAME)
	@echo $(CURSIVE)$(GRAY) "     - Compiling $(NAMESRV)..." $(NONE)
	@gcc $(FLAGS) $(OBJBONUSSRV) $(LINKS) -o $(NAMESRV) libft.a
	@echo $(CURSIVE)$(GRAY) "     - Compiling $(NAME)..." $(NONE)
	@gcc $(FLAGS) $(OBJBONUSCL) $(LINKS) -o $(NAME) libft.a
	@echo $(GREEN)"- Compiled -"$(NONE)

clean:
	@echo $(CURSIVE)$(GRAY) "     - Removing object files..." $(NONE)
	@rm -rf $(OBJCL) $(OBJSRV) $(OBJBONUSCL) $(OBJBONUSSRV)
	@$(MAKE) -C ./libft clean

fclean: clean
	@echo $(CURSIVE)$(GRAY) "     - Removing $(NAME), $(NAMESRV) And $(LIBNAME)..." $(NONE)
	@rm -rf $(NAME) $(NAMESRV) $(LIBNAME)
	@$(MAKE) -C ./libft fclean

re: fclean all