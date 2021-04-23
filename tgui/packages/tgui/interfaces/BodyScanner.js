import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { AnimatedNumber, Box, Button, Flex, Icon, LabeledList, ProgressBar, Section, Table, Tooltip } from "../components";
import { Window } from "../layouts";

const stats = [
  ['good', 'Жив'],
  ['average', 'Без сознания'],
  ['bad', 'СМЕРТЬ'],
];

const abnormalities = [
  ['hasBorer', 'bad', occupant => 'Сильный рост обнаружен в лобной доле,'
    + ' возможно, злокачественное. Рекомендуется хирургическое удаление.'],
  ['hasVirus', 'bad', occupant => 'Вирусный патоген обнаружен в кровотоке.'],
  ['blind', 'average', occupant => 'Обнаружена катаракта.'],
  ['colourblind', 'average', occupant => 
    'Обнаружены аномалии фоторецепторов.'],
  ['nearsighted', 'average', occupant => 'Обнаружено смещение сетчатки.'],
  /* VOREStation Add */
  ['humanPrey', 'average', occupant => {
    return 'Обнаружен чужеродный гуманоид(Ы): ' + occupant.humanPrey;
  }],
  ['livingPrey', 'average', occupant => {
    return 'Обнаружено инородное существо(а): ' + occupant.livingPrey;
  }],
  ['objectPrey', 'average', occupant => {
    return 'Обнаружен посторонний(ние) предмет(ы): ' + occupant.objectPrey;
  }],
  /* VOREStation Add End */
];

const damages = [
  ['Дыхание', 'oxyLoss'],
  ['Мозг', 'brainLoss'],
  ['Токсины', 'toxLoss'],
  ['Радиация', 'radLoss'],
  ['Поврежд.', 'bruteLoss'],
  ['Генетика', 'cloneLoss'],
  ['Ожоги', 'fireLoss'],
  ['Паралич', 'paralysis'],
];

const damageRange = {
  average: [0.25, 0.5],
  bad: [0.5, Infinity],
};

const mapTwoByTwo = (a, c) => {
  let result = [];
  for (let i = 0; i < a.length; i += 2) {
    result.push(c(a[i], a[i + 1], i));
  }
  return result;
};

const reduceOrganStatus = A => {
  return A.length > 0
    ? A.reduce((a, s) =>
      a === null
        ? s : (
          <Fragment>
            {a}
            {!!s && (
              <Box>
                {s}
              </Box>
            )}
          </Fragment>
        ))
    : null;
};

const germStatus = i => {
  if (i > 100) {
    if (i < 300) { return "mild infection"; }
    if (i < 400) { return "mild infection+"; }
    if (i < 500) { return "mild infection++"; }
    if (i < 700) { return "acute infection"; }
    if (i < 800) { return "acute infection+"; }
    if (i < 900) { return "acute infection++"; }
    if (i >= 900) { return "septic"; }
  }

  return "";
};

export const BodyScanner = (props, context) => {
  const { data } = useBackend(context);
  const {
    occupied,
    occupant = {},
  } = data;
  const body = occupied ? (
    <BodyScannerMain occupant={occupant} />
  ) : (
    <BodyScannerEmpty />
  );
  return (
    <Window
      width={690}
      height={600}
      resizable>
      <Window.Content scrollable className="Layout__content--flexColumn">
        {body}
      </Window.Content>
    </Window>
  );
};

const BodyScannerMain = props => {
  const {
    occupant,
  } = props;
  return (
    <Box>
      <BodyScannerMainOccupant occupant={occupant} />
      <BodyScannerMainReagents occupant={occupant} />
      <BodyScannerMainAbnormalities occupant={occupant} />
      <BodyScannerMainDamage occupant={occupant} />
      <BodyScannerMainOrgansExternal organs={occupant.extOrgan} />
      <BodyScannerMainOrgansInternal organs={occupant.intOrgan} />
    </Box>
  );
};

const BodyScannerMainOccupant = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    occupant,
  } = data;
  return (
    <Section
      title="Пациент"
      buttons={(
        <Fragment>
          <Button
            icon="user-slash"
            onClick={() => act('ejectify')}>
            Извлечь
          </Button>
          <Button
            icon="print"
            onClick={() => act('print_p')}>
            Печать отчета
          </Button>
        </Fragment>
      )}>
      <LabeledList>
        <LabeledList.Item label="Ф.И">
          {occupant.name}
        </LabeledList.Item>
        <LabeledList.Item label="Здоровье">
          <ProgressBar
            min="0"
            max={occupant.maxHealth}
            value={occupant.health / occupant.maxHealth}
            ranges={{
              good: [0.5, Infinity],
              average: [0, 0.5],
              bad: [-Infinity, 0],
            }}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Состояние" color={stats[occupant.stat][0]}>
          {stats[occupant.stat][1]}
        </LabeledList.Item>
        <LabeledList.Item label="Температура">
          <AnimatedNumber
            value={round(occupant.bodyTempC, 0)}
          />&deg;C,&nbsp;
          <AnimatedNumber
            value={round(occupant.bodyTempF, 0)}
          />&deg;F
        </LabeledList.Item>
        <LabeledList.Item label="Уровень крови">
          <AnimatedNumber
            value={round(occupant.blood.volume, 0)}
          /> units&nbsp;(
          <AnimatedNumber
            value={round(occupant.blood.percent, 0)}
          />%)
        </LabeledList.Item>
        {/* VOREStation Add */}
        <LabeledList.Item label="Вес">
          {round(data.occupant.weight) + "lbs, "
            + round(data.occupant.weight/2.20463) + "kgs"}
        </LabeledList.Item>
        {/* VOREStation Add End */}
      </LabeledList>
    </Section>
  );
};

const BodyScannerMainReagents = props => {
  const {
    occupant,
  } = props;

  return (
    <Fragment>
      <Section title="Реагенты крови">
        {occupant.reagents ? (
          <Table>
            <Table.Row header>
              <Table.Cell>
                Reagent
              </Table.Cell>
              <Table.Cell textAlign="right">
                Количество
              </Table.Cell>
            </Table.Row>
            {occupant.reagents.map(reagent => (
              <Table.Row key={reagent.name}>
                <Table.Cell>{reagent.name}</Table.Cell>
                <Table.Cell textAlign="right">
                  {reagent.amount} Юнитов {
                    reagent.overdose
                      ? <Box color="bad">ПЕРЕДОЗИРОВКА</Box>
                      : null
                  }
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        ) : <Box color="good">Реагенты в крови не обнаружены</Box>}
      </Section>
      <Section title="Реагенты в желудке">
        {occupant.ingested ? (
          <Table>
            <Table.Row header>
              <Table.Cell>
                Reagent
              </Table.Cell>
              <Table.Cell textAlign="right">
                Количество
              </Table.Cell>
            </Table.Row>
            {occupant.ingested.map(reagent => (
              <Table.Row key={reagent.name}>
                <Table.Cell>{reagent.name}</Table.Cell>
                <Table.Cell textAlign="right">
                  {reagent.amount} Юнитов {
                    reagent.overdose
                      ? <Box color="bad">ПЕРЕДОЗИРОВКА</Box>
                      : null
                  }
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        ) : <Box color="good">Реагенты в желудке не обнаружены</Box>}
      </Section>
    </Fragment>
  );
};

const BodyScannerMainAbnormalities = props => {
  const {
    occupant,
  } = props;

  let hasAbnormalities = occupant.hasBorer
    || occupant.blind
    || occupant.colourblind
    || occupant.nearsighted
    || occupant.hasVirus;

  /* VOREStation Add */
  hasAbnormalities = hasAbnormalities
    || occupant.humanPrey
    || occupant.livingPrey
    || occupant.objectPrey;
  /* VOREStation Add End */

  if (!hasAbnormalities) {
    return (
      <Section title="Аномалии">
        <Box color="label">
          Отклонений не обнаружено.
        </Box>
      </Section>
    );
  }

  return (
    <Section title="Аномалии">
      {abnormalities.map((a, i) => {
        if (occupant[a[0]]) {
          return (
            <Box color={a[1]} bold={a[1] === "bad"}>
              {a[2](occupant)}
            </Box>
          );
        }
      })}
    </Section>
  );
};

const BodyScannerMainDamage = props => {
  const {
    occupant,
  } = props;
  return (
    <Section title="Урон">
      <Table>
        {mapTwoByTwo(damages, (d1, d2, i) => (
          <Fragment>
            <Table.Row color="label">
              <Table.Cell>
                {d1[0]}:
              </Table.Cell>
              <Table.Cell>
                {!!d2 && d2[0] + ":"}
              </Table.Cell>
            </Table.Row>
            <Table.Row>
              <Table.Cell>
                <BodyScannerMainDamageBar
                  value={occupant[d1[1]]}
                  marginBottom={i < (damages.length - 2)}
                />
              </Table.Cell>
              <Table.Cell>
                {!!d2 && (
                  <BodyScannerMainDamageBar value={occupant[d2[1]]} />
                )}
              </Table.Cell>
            </Table.Row>
          </Fragment>
        ))}
      </Table>
    </Section>
  );
};

const BodyScannerMainDamageBar = props => {
  return (
    <ProgressBar
      min="0"
      max="100"
      value={props.value / 100}
      mt="0.5rem"
      mb={!!props.marginBottom && "0.5rem"}
      ranges={damageRange}>
      {round(props.value, 0)}
    </ProgressBar>
  );
};

const BodyScannerMainOrgansExternal = props => {
  if (props.organs.length === 0) {
    return (
      <Section title="Внутренние органы">
        <Box color="label">
          N/A
        </Box>
      </Section>
    );
  }

  return (
    <Section title="Внешние органы">
      <Table>
        <Table.Row header>
          <Table.Cell>
            Название
          </Table.Cell>
          <Table.Cell textAlign="center">
            Урон
          </Table.Cell>
          <Table.Cell textAlign="right">
            Травмы
          </Table.Cell>
        </Table.Row>
        {props.organs.map((o, i) => (
          <Table.Row key={i} textTransform="capitalize">
            <Table.Cell width="33%">
              {o.name}
            </Table.Cell>
            <Table.Cell textAlign="center" q>
              <ProgressBar
                min="0"
                max={o.maxHealth}
                mt={i > 0 && "0.5rem"}
                value={o.totalLoss / 100}
                ranges={damageRange}>
                <Box float="left" display="inline">
                  {!!o.bruteLoss && (
                    <Box display="inline" position="relative">
                      <Icon name="bone" />
                      {round(o.bruteLoss, 0)}&nbsp;
                      <Tooltip
                        position="top"
                        content="Повреждения"
                      />
                    </Box>)}
                  {!!o.fireLoss && (
                    <Box display="inline" position="relative">
                      <Icon name="fire" />
                      {round(o.fireLoss, 0)}
                      <Tooltip
                        position="top"
                        content="Ожоги"
                      />
                    </Box>)}
                </Box>
                <Box display="inline">
                  {round(o.totalLoss, 0)}
                </Box>
              </ProgressBar>
            </Table.Cell>
            <Table.Cell
              textAlign="right"
              width="33%">
              <Box color="average" display="inline">
                {reduceOrganStatus([
                  o.internalBleeding && "Internal bleeding",
                  !!o.status.bleeding && "External bleeding",
                  o.lungRuptured && "Разорванное легкое",
                  o.destroyed && "Разрушено",
                  !!o.status.broken && o.status.broken,
                  germStatus(o.germ_level),
                  !!o.open && "Открытый разрез",
                ])}
              </Box>
              <Box display="inline">
                {reduceOrganStatus([
                  !!o.status.splinted && "Шинированно",
                  !!o.status.robotic && "Роботическое",
                  !!o.status.dead && (
                    <Box color="bad">
                      СМЕРТЬ
                    </Box>
                  ),
                ])}
                {reduceOrganStatus(o.implants.map(
                  s => s.known
                    ? s.name
                    : "Неизвестный объект"
                ))}
              </Box>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const BodyScannerMainOrgansInternal = props => {
  if (props.organs.length === 0) {
    return (
      <Section title="Внутренние органы">
        <Box color="label">
          N/A
        </Box>
      </Section>
    );
  }

  return (
    <Section title="Внутренние органы">
      <Table>
        <Table.Row header>
          <Table.Cell>
            Name
          </Table.Cell>
          <Table.Cell textAlign="center">
            Damage
          </Table.Cell>
          <Table.Cell textAlign="right">
            Injuries
          </Table.Cell>
        </Table.Row>
        {props.organs.map((o, i) => (
          <Table.Row key={i} textTransform="capitalize">
            <Table.Cell width="33%">
              {o.name}
            </Table.Cell>
            <Table.Cell textAlign="center">
              <ProgressBar
                min="0"
                max={o.maxHealth}
                value={o.damage / 100}
                mt={i > 0 && "0.5rem"}
                ranges={damageRange}>
                {round(o.damage, 0)}
              </ProgressBar>
            </Table.Cell>
            <Table.Cell
              textAlign="right"
              width="33%">
              <Box color="average" display="inline">
                {reduceOrganStatus([
                  germStatus(o.germ_level),
                  !!o.inflamed && "Appendicitis detected.",
                ])}
              </Box>
              <Box display="inline">
                {reduceOrganStatus([
                  (o.robotic === 1) && "Robotic",
                  (o.robotic === 2) && "Assisted",
                  !!o.dead && (
                    <Box color="bad">
                      СМЕРТЬ
                    </Box>
                  ),
                ])}
              </Box>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const BodyScannerEmpty = () => {
  return (
    <Section textAlign="center" flexGrow="1">
      <Flex height="100%">
        <Flex.Item grow="1" align="center" color="label">
          <Icon
            name="user-slash"
            mb="0.5rem"
            size="5"
          /><br />
          Пациент не обнаружен.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
