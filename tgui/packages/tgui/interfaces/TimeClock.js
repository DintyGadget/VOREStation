import { toFixed } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section, NoticeBox } from "../components";
import { Window } from "../layouts";
import { RankIcon } from "./common/RankIcon";

export const TimeClock = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    department_hours,
    user_name,
    card,
    assignment,
    job_datum,
    allow_change_job,
    job_choices,
  } = data;

  return (
    <Window width={500} height={520} resizable>
      <Window.Content scrollable>
        <Section title="OOC">
          <NoticeBox>
            Примечание OOC: Оплачиваемое время отпуска зарабатывается аккаунтом и действует на каждого персонажа.
            Информация ниже не является IC.
          </NoticeBox>
          <Section level={2} title={"Доступное время отгула для: " + user_name}>
            <LabeledList>
              {Object.keys(department_hours).map(key => (
                <LabeledList.Item
                  key={key}
                  label={key}
                  color={
                    department_hours[key] > 6
                      ? "good"
                      : department_hours[key] > 1
                        ? "average"
                        : "bad"
                  }>
                  {toFixed(department_hours[key], 1)} ч.
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        </Section>
        <Section title="Информация о сотруднике">
          <LabeledList>
            <LabeledList.Item label="ID сотрудника">
              <Button
                fluid
                icon="user"
                onClick={() => act("id")}>
                {card || "Вставить ID"}
              </Button>
            </LabeledList.Item>
            {!!job_datum && (
              <Fragment>
                <LabeledList.Item label="Rank">
                  <Box
                    backgroundColor={job_datum.selection_color}
                    p={0.8}>
                    <Flex justify="space-between" align="center">
                      <Flex.Item>
                        <Box ml={1}>
                          <RankIcon color="white" rank={job_datum.title} />
                        </Box>
                      </Flex.Item>
                      <Flex.Item>
                        <Box fontSize={1.5} inline mr={1}>
                          {job_datum.title}
                        </Box>
                      </Flex.Item>
                    </Flex>
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Отделы">
                  {job_datum.departments}
                </LabeledList.Item>
                <LabeledList.Item label="Размер зарплаты">
                  {job_datum.economic_modifier}
                </LabeledList.Item>
                <LabeledList.Item label="Допуск оплачиваемых отгулов">
                  {job_datum.timeoff_factor > 0 && (
                    <Box>
                      Earns PTO - {job_datum.pto_department}
                    </Box>
                  ) || job_datum.timeoff_factor < 0 && (
                    <Box>
                      Requires PTO - {job_datum.pto_department}
                    </Box>
                  ) || (
                    <Box>
                      Neutral
                    </Box>
                  )}
                </LabeledList.Item>
              </Fragment>
            )}
          </LabeledList>
        </Section>
        {!!(allow_change_job && job_datum && job_datum.timeoff_factor !== 0 && assignment !== "Dismissed") && (
          <Section title="Действия сотрудника">
            {job_datum.timeoff_factor > 0 && (
              department_hours[job_datum.pto_department] > 0 && (
                <Button
                  fluid
                  icon="exclamation-triangle"
                  onClick={() => act("switch-to-offduty")}>
                  Взять отгул
                </Button>
              ) || (
                <Box color="bad">
                  Внимание: Вы отработали недостаточно времени, чтобы уйти на отгул.
                </Box>
              )
            ) || (
              Object.keys(job_choices).length && Object.keys(job_choices).map(job => {
                let alt_titles = job_choices[job];

                return alt_titles.map(title => (
                  <Button
                    key={title}
                    icon="suitcase"
                    onClick={() => act("switch-to-onduty-rank", {
                      "switch-to-onduty-rank": job,
                      "switch-to-onduty-assignment": title,
                    })}>
                    {title}
                  </Button>
                ));
              }) || (
                <Box color="bad">
                  Отсутствуют доступные позиции - Свяжитесь с Главой персонала.
                </Box>
              )
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};