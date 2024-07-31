/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jzubizar <jzubizar@student.42urduliz.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/08/04 13:22:52 by josu              #+#    #+#             */
/*   Updated: 2023/08/07 10:50:02 by jzubizar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include"minitalk.h"

//Function to send a char (1 byte)
//bit by bit, using USR1 as 1 and USR2 as 0
void	ft_send_char(char c, int pid)
{
	int	i;
	int	bit;

	i = 8;
	while (i--)
	{
		bit = c >> i & 1;
		if (bit)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		usleep(1000);
	}
}

//Function to handle USR1 signal received
void	ft_handle_client(int sig)
{
	if (sig == SIGUSR1)
		ft_printf("Bit recibido\n");
}

int	main(int argc, char **argv)
{
	int					i;
	int					pid;
	struct sigaction	sa;

	sa.sa_handler = &ft_handle_client;
	sigaction(SIGUSR1, &sa, NULL);
	i = 0;
	if (argc == 3)
	{
		pid = ft_atoi(argv[1]);
		while (argv[2][i] != '\0')
		{
			ft_send_char(argv[2][i], pid);
			i++;
		}
	}
	return (0);
}
